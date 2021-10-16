### `传统方式`

```golang
type Redis struct {
	Host string
	Port int
	Pass string
	Tls  bool
	Db   int
}
```

>配置中有一些参数是必传的, 例如: `Host`; 一些可以是可选的, 例如: `Pass`、`Tls`、`Db`

#### `一般使用`

```golang
func NewRedis(host, pass string, db, port int, tls bool) *Redis {
	return &Redis{
		Host: host,
		Port: port,
		Pass: pass,
		Tls:  tls,
		Db:   db,
	}
}
```

>带来的问题:

- 不支持默认值, 必须传入
- 顺序固定
- 扩展性差
- 不支持多个传入

### `function option`

```golang
type (
	Option func(r *Redis)

	Redis struct {
		Host    string
		Port    int
		Pass    string
		Tls     bool
		Db      int
	}
)

func NewRedis(host string, port int, options ...Option) *Redis {
	r := &Redis{
		Host: host,
		Port: port,
	}

	for _, o := range options {
		o(r)
	}

	return r
}

func WithPass(pass string) Option {
	return func(r *Redis) {
		r.Pass = pass
	}
}

func WithTls(tls bool) Option {
	return func(r *Redis) {
		r.Tls = tls
	}
}

func WithDb(db int) Option {
	return func(r *Redis) {
		r.Db = db
	}
}

// r := NewRedis("127.0.0.1", 6379, WithPass("sane"))
```

- 好处:
  - 支持默认值
  - 无须按照顺序传入
  - 扩展性好
  - 支持不定参数传入

- 坏处:
  - `function` 太多, 编码成本较高

### 参考

-[function option](https://coolshell.cn/articles/21146.html#Functional_Options)
