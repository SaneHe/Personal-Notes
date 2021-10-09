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

### 堆、栈是什么

- 堆 
- 栈
