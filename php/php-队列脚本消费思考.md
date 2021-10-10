## 背景

>由于目前的工作会经常需要涉及到队列消费这一场景, 公司的主要写法如下 (cli):

```php
namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Redis;

class ExampleCommand extends Command
{
    public $redis;

    protected $signature = 'consumer:example';

    public function __construct()
    {
        parent::__construct();
        $this->redis = Redis::connection('queue');
    }

    public function handle()
    {
        while (true) {
            if ($this->redis->llen($this->queue)) {
                $data = $this->redis->rpop('example');
                // do something with data 
                continue;
            }

            sleep(numSecond);
        }
    }
}
```

## 这种常驻的例子中, 随着处理任务, 时长的增加占用内存增大, 产生的原因又是什么呢? 该如何处理呢? 

### 原因

>执行时产生的内存消耗没有释放掉?! 可是 `php` 不是有 [垃圾回收机制](https://www.php.net/manual/zh/features.gc.php) 吗? 

#### 垃圾回收机制

- 引用计数
  - `标量`
    - 每个 `php` 变量存在一个叫 `zval` 的变量容器中。一个 `zval` 变量容器，除了包含变量的类型和值，还包括两个字节的额外信息。第一个是 `is_ref`，是个 `bool` 值，用来标识这个变量是否是属于`引用集合` ( `reference set`). 通过这个字节，`php 引擎` 才能把`普通变量`和`引用变量`区分开来，由于 php 允许用户通过使用 `&` 来使用`自定义引用`，`zval` 变量容器中还有一个内部引用计数机制，来优化内存使用. 第二个额外字节是 `refcount`，用以表示指向这个 `zval` 变量容器的变量(也称符号即 `symbol`)个数. 当主动 `unset` 或者 `当任何关联到某个变量容器的变量离开它的作用域` 时, `refcount` 就会减 `1`. 变量容器在 `refcount` 变成 `0` 时就被销毁.
  
  - `非标量`, 即 `array` 或 `object`
    - 与 `标量`(`scalar`)类型的值不同, `array` 和 `object` 类型的变量把它们的`成员`或`属性`存在自己的符号表中, 会对其`成员`或`属性`以及当前变量分别生成 `zval` 变量容器; 删除数组中的一个元素，就是类似于从作用域中删除一个变量. 删除后,数组中的这个元素所在的容器的 `refcount` 值减少，同样，当 `refcount` 为0时，这个变量容器就从内存中被删除
  
        ```php
        <?php
        $a = array( 'meaning' => 'life', 'number' => 42 );
        $a['life'] = $a['meaning'];
        xdebug_debug_zval( 'a' );
        ?>

        // 输出如下
        a: (refcount=1, is_ref=0)=array (
        'meaning' => (refcount=2, is_ref=0)='life',
        'number' => (refcount=1, is_ref=0)=42,
        'life' => (refcount=2, is_ref=0)='life'
        )
        ```


- [回收周期](https://www.php.net/manual/zh/features.gc.collecting-cycles.php)
  
### 解决方法

- 脚本增加定时执行或者周期实现 `crontab`
- 手动 `unset` 后使用 [`gc_collect_cycles`](https://www.php.net/manual/zh/function.gc-collect-cycles.php) 强制回收内存
- 设置最大内存或者根据执行时长、睡眠时间等, 增加守护进程拉起; 如: `pm2`, `supervisor`, `systemd`

### 注意事项

- [memory_get_usage](https://www.php.net/manual/zh/function.memory-get-usage.php)

![memory_get_usage](/media/php_memory_get_usage.png)

> 无论你传入的参数值为 `true` 或 `false` 都不一定是实际 `php` 进程所请求的内存大小, 因为 `PHP 不跟踪非emalloc() 分配的内存`
