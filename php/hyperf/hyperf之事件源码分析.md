# `事件模式` (引用官方)

- `事件(Event)` 是传递于应用代码与 
- `监听器(Listener)` 之间的通讯对象 `监听器(Listener)` 是用于监听 `事件(Event)` 的发生的监听对象
- `事件调度器(EventDispatcher)` 是用于触发 `事件(Event)` 和管理 `监听器(Listener)` 与 `事件(Event)` 之间的关系的管理者对象

## `hyperf` 事件 (不包含注解)

- 使用方法
    - 定义事件
  
        ```php
        <?php
        namespace App\Event;

        class UserRegistered
        {
            // 建议这里定义成 public 属性，以便监听器对该属性的直接使用，或者你提供该属性的 Getter
            public $user;
            
            public function __construct($user)
            {
                $this->user = $user;    
            }
        }
        ```
    - 定义监听器
        ```php
        <?php
        namespace App\Listener;

        use App\Event\UserRegistered;
        use Hyperf\Event\Contract\ListenerInterface;

        class UserRegisteredListener implements ListenerInterface
        {
            public function listen(): array
            {
                // 返回一个该监听器要监听的事件数组，可以同时监听多个事件
                return [
                    UserRegistered::class,
                ];
            }

            /**
             * @param UserRegistered $event
             */
            public function process(object $event)
            {
                // 事件触发后该监听器要执行的代码写在这里，比如该示例下的发送用户注册成功短信等
                // 直接访问 $event 的 user 属性获得事件触发时传递的参数值
                // $event->user;
                
            }
        }
        ```
    - 注册监听器
        ```php
        // 事件调度器(Dispatcher) 发现，可以在 config/autoload/listeners.php 配置文件
        <?php
            return [
                \App\Listener\UserRegisteredListener::class,
            ];
        ```
    - 触发事件
        ```php
       <?php
        namespace App\Service;

        use Hyperf\Di\Annotation\Inject;
        use Psr\EventDispatcher\EventDispatcherInterface;
        use App\Event\UserRegistered; 

        class UserService
        {
            /**
            * @Inject 
            * @var EventDispatcherInterface
            */
            private $eventDispatcher;
            
            public function register()
            {
                // 我们假设存在 User 这个实体
                $user = new User();
                $result = $user->save();
                // 完成账号注册的逻辑
                // 这里 dispatch(object $event) 会逐个运行监听该事件的监听器
                $this->eventDispatcher->dispatch(new UserRegistered($user));
                return $result;
            }
        }
        ```



### 源码分析

- 首先框架先加载 [ConfigProvider](https://github.com/hyperf/event/blob/master/src/ConfigProvider.php#L23) 文件, 分别注册并绑定 `监听器(Listener)` 和 `事件调度器(EventDispatcher)` 的服务提供者
  
- [`监听器(Listener)` 服务提供者工厂](https://github.com/hyperf/event/blob/9c2ab56737d080d799b9b1f905716c7bf0d61ef6/src/ListenerProviderFactory.php#L27)
  
  >实例化 `Hyperf\Event\ListenerProvider` [监听器服务提供者](https://github.com/hyperf/event/blob/9c2ab56737d080d799b9b1f905716c7bf0d61ef6/src/ListenerProviderFactory.php#L24)

  >注册配置文件 调用 `registerConfig`方法, 即 `config/autoload/listeners.php`; 取出所有监听器后调用 `register` 方法, 获取监听器实例, 执行其 `listen`方法获取监听事件; 然后将 `监听器实例` 、处理逻辑 (`process` 这也是监听器中必须实现 `process` 方法, 完成业务逻辑的原因) 、以及 `事件等级` (`$priority`) 作为参数调用 `监听器服务提供者` (`ListenerProvider`) 的 `on` 方法

  > [on](https://github.com/hyperf/event/blob/9c2ab56737d080d799b9b1f905716c7bf0d61ef6/src/ListenerProvider.php#L40) 方法的逻辑比较简单, 根据传入的参数实例出一个 [ListenerData](https://github.com/hyperf/event/blob/9c2ab56737d080d799b9b1f905716c7bf0d61ef6/src/ListenerData.php#L14) 然后放入到自己的 `listeners` 属性中


- [`事件调度器(EventDispatcher)` 服务提供者工厂](https://github.com/hyperf/event/blob/9c2ab56737d080d799b9b1f905716c7bf0d61ef6/src/EventDispatcherFactory.php#L18)

    >当触发 `事件(Event)` 时, 传入 `$event` 参数调用 `dispatch` 方法;

    >首先获取到当前 `监听器的服务提供者`, 循环根据 `$event` 参数调用 `getListenersForEvent` 获取到对应的监听器实例以及要调用的方法 (即为 监听器实例以及 `process` 方法), 然后直接调用
    >`getListenersForEvent` 是将自身属性 `listeners` 循环插入到 `SplPriorityQueue` 中, 以供后续的事件按优先级触发使用

    >之后的 `StoppableEventInterface` 实例以及是否继续冒泡事件判断


# 参考

- [php callable](https://www.php.net/manual/zh/language.types.callable.php)
- [php splpriorityqueue](https://www.php.net/manual/zh/class.splpriorityqueue.php)
- [hyperf event](https://hyperf.wiki/2.2/#/zh-cn/event?id=%e5%89%8d%e8%a8%80)
