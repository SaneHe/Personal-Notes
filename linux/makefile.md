# `Makefile`

> `Makefile` 定义编译构建规则的一个配置文件，用于 [make](https://en.wikipedia.org/wiki/Make_%28software%29) 自动化构建应用程序

### 格式

> `Makefile` 文件是由一系列自定义的规则构成，规则形式如下：

```
<target> : <prerequisites> 
[tab]  <commands>
```

- `target` (目标-必填) 可以理解为 `make` 的命令扩展, 默认执行第一个 `target`
- `prerequisites` (先决条件-可选) 执行当前命令之前需执行的条件，例如: 一个项目需要安装完依赖后执行
- `tab` 必须空一个 `tab` 键位
- `commands`  (可选) 执行的命令，多条命令是在不同的 `shell` 进程执行，若希望合并命令，可以按照 `shell` 的 `\` 合并
- `#` 注释
- `@` 即终端不会打印真实的执行命令
- `${val}` 表示变量，和 `shell` 脚本中的变量的声明和使用一致
- 允许使用 通配符
- `.PHONY` 伪造，内置的关键字，可以理解为指定 `target` 导出使用

### `go` 例子

```makefile
PROJECT="server"

GOFILES=`find . -name "*.go" -type f -not -path "./vendor/*"`

default:
	echo ${PROJECT}
    @go build -o ${server}

fmt:
	@gofmt -s -w ${GOFILES}

install:
	@go mod tidy

test: install
	@go test ./
    
docker:
    @docker build -t server:latest .

.PHONY: default fmt install test docker
```
