### 背景

>工作使用的 `go` 框架是好未来团队开源的 [go-zero](https://github.com/zeromicro/go-zero)  

- 场景中遇到了一个情况, `A` 服务需要的一份公共数据, 此数据是由 `B` 服务负责处理, 处理完成后放到 `C` 公共存储服务中
- `A` 服务发生并发情况下, 希望仅触发 `B` 服务的一次逻辑计算, `A` 服务拿到结果后直接返回; 后续请求希望不要触发 `B` 服务的计算
- `A` 服务此接口需具备超时功能

#### 实现

```golang
type Fn func() (interface{}, error)

func doSomething(fn1 Fn, fn2 Fn, cacheKey string, seconds int) (interface{}, error) {

	redisLock := redis.NewRedisLock(redisInstance, cacheKey)
	redisLock.SetExpire(seconds)

	if ok, _ := redisLock.Acquire(); ok {
		defer func() {
			recover()
			redisLock.Release()
		}()

		if response, err := fn1(); err == nil {
			return response, nil
		}
	}

	var (
		err      error
		response interface{}
		done     = make(chan struct{})
	)

	err = fx.DoWithTimeout(func() error {
		for {
			select {
			case done <- struct{}{}:
				return nil
			default:
				if response, err = fn2(); err == nil {
					close(done)
					return nil
				}

				time.Sleep(time.Millisecond * 100)
			}
		}

		return nil
	}, time.Duration(seconds)*time.Second)

	<-done

	return response, err
}
```

>以上实现欢迎交流;有几点问题没有完全明白,特意记录到下面 (调用函数后打印下协程数)

- 将 `close(done)` 换成  `done <- struct{}{}`

- 读、写通道互换位置
  
    ```golang
    err = fx.DoWithTimeout(func() error {
            for {
                select {
                case <-done:
                    return nil
                default:
                    if response, err = fn2(); err == nil {
                        <-done
                        return nil
                    }

                    time.Sleep(time.Millisecond * 100)
                }
            }

            return nil
        }, time.Duration(seconds)*time.Second)

        done <- struct{}{}
    ```

- 将 `default` 换成 ` time.after`
  
    ```golang

    case <-time.After(time.Millisecond * 100):
        if response, err = fn2(); err == nil {
            // 再使用上面的两层逻辑
            return nil
        }
    ```

### 参考

- [go-zero timeout](https://github.com/zeromicro/go-zero/blob/master/core/fx/timeout.go#L22)
- [go-zero redis lock](https://github.com/zeromicro/go-zero/blob/master/core/stores/redis/redislock.go#L44)
- [go-zero docs](https://go-zero.dev/cn/redis-lock.html)
