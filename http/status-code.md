## `HTTP` 状态码

HTTP状态码是用于表示网页服务器超文本传输协议响应状态的3位数字代码。

### 1xx：信息性状态码

- 100 `Continue` 服务器已经接受客户端请求，客户端可以继续发送请求；
- 101 `Switchs Protocols` 服务器已经理解了客户端的请求，并将通过 `Upgrade` 消息头通知客户端采用不同的协议来完成这个请求；
- 102 `Processing` 由 `WebDAV（RFC 2518）` 扩展的状态码，代表处理将被继续执行。

### 2xx: 表示请求已成功被服务器接收、理解，并接受

+ 200 `OK` 服务器已成功处理了请求；
+ 201 `Created` 请求成功，并且服务器建立了新的资源；
+ 202 `Accepted` 服务器已接受请求，但尚未处理。请求可能被执行也可能不被执行，其目标是允许服务器接受其他过程的请求；
+ 203 `Non-Authoritative Information(非授权信息)`，服务器已成功处理了请求，但返回的信息可能来自本地或者第三方的拷贝；
+ 204 `No Content` 服务器已成功处理了请求，但不需要返回任何实体内容，并且希望返回更新了的元信息；
+ 205 `Reset Content` 服务器已成功处理了请求，且没有返回任何内容。其作用是要求请求者重置文档视图，如表单重置，让用户轻松开始另一次输入；
+ 206 `Partial Content` 服务器已经成功处理了部分get请求。类似于迅雷等HTTP下载工具，使用此类响应实现断点续传或将一个大文档分解为多个下载段同时下载；
+ 207 `Multi-Status 由WebDAV(RFC 2518)` 扩展的状态码，代表之后的消息体将是一个 `XML` 消息，并且依照之前子请求数量的不同，包含一系列独立的响应代码。

### 3xx：表示需要客户端采取进一步的操作才能完成请求。通常，这类状态码被用来重定向

* 300 `Multiple Choice` 被请求的资源有一系列可供选择回馈的信息，浏览器能够自行选择一个首选的地址进行重定向；
* 301 `Moved Permanently` 被请求的资源已永久移动到新位置。服务器返回此(对 `GET` 或 `HEAD` 请求的)响应时，会自动将请求者转移到新地址；
* 302 `Move temporarily` 服务器目前从不同的地址响应请求，但客户端以后应当继续向原有的地址发送请求；
* 303 `See Other` 对应当前请求的响应可以在另一个 `URI` 上被找到，且客户端应当使用GET方式访问那个资源；
* 304 `Not Modified` 自从上次请求后，请求的资源未被修改过。服务器返回此响应时，不会返回内容；
* 305 `Use Proxy` 被请求的资源必须通过指定的代理才能访问到；
* 306 `Switch Proxy` 在最新版本的规范中，`306` 状态码已不再使用；
* 307 `Temporary Redirct` 请求的资源临时从不同的 `URI` 响应请求；需使用 `GET/HEAD` 请求，否则浏览器禁止自动重定向；

### 4xx：客户端请求错误
- 400 `Bad Request` 语义错误或请求参数错误，当前请求无法被服务器理解；
- 401 `Unauthorized` 当前请求需要用户身份验证；
- 402 `Payment Required` 该状态码是为了将来需要而预留的；
- 403 `Forbidden` 服务器已理解请求，但拒绝执行它；
- 404 `Not Found` 请求的资源在服务器上未找到；
- 405 `Method Not Allowed` 禁止使用请求中指定的请求方法；
- 406 `Not Acceptable` 无法使用请求资源的内容特性，生成响应实体；
- 407 `Proxy Authentication Required` 类似 `401`，客户端必须在代理服务器上进行身份验证；
代理服务器必须返回一个 `Proxy-Authenticate` 用以进行身份询问。
客户端可以返回一个 `Proxy-Authorization` 信息头用以验证。
- 408 `Request Timeout` 请求超时；
- 409 `Conflict` 服务器处理请求资源时，与当前状态发生冲突。服务器必须在响应中包含有关冲突的信息；
- 410 `Gone` 被请求的资源在服务器上已永久删除；
- 411 `Length Required` 服务器拒绝在没有定义 `Content-Length` 头的情况下接受请求；
- 412 `Precondition Failed(未满足前提条件)` 服务器未满足请求者在请求的头字段中设置的一个或多个条件；
- 413 `Request Entity too Large` 请求实体过大，超出服务器处理范围，服务器拒绝处理请求；
- 414 `Request URI too Long` 请求的 `URI` 过长，服务器拒绝处理请求；
- 415 `Unsupported Media Type` 请求中提交的实体不是服务器所支持的类型，服务器拒绝处理请求；
- 416 `Requested Range Not Satisfiable` 如果无法提供请求范围，服务器则返回此状态码；
- 417 `Expectation Failed` 服务器未满足请求头 `Expect` 中指定的预期内容；
- 421 `too many connections` 从当前客户端所在的IP地址到服务器的连接数超过了服务器许可的最大范围；
- 422 `Unprocessable Entity` 请求格式正确，但是由于含有语义错误，无法响应；
- 423 `Locked` 当前资源被锁定；
- 424 `Failed Dependency` 由于之前的某个请求发生的错误，导致当前请求失败；

### 5xx：表示服务器在处理请求的过程中有错误或异常状态发生

- 500 `Interal Server Error` 服务器内部错误，无法完成对请求的处理；
- 501 `Not Implemented` 服务器不支持当前请求所需要的某个功能，如：服务器无法识别请求的方法；
- 502 `Bad Gateway(错误网关)` 当服务器作为网关或代理，从上游服务器收到无效响应；
- 503 `Service Unavailable` 服务器目前不可用(由于维护或过载)，此状态是临时的；
- 504 `Gateway Timeout(网关超时)` 服务器作为网关或代理，未能及时从上游服务器获得响应；
- 505 `HTTP Verson Not Supported` 服务器不支持在请求中使用的 `HTTP` 版本协议；
- 506 `Variant Also Negotiates` 代表服务器存在内部配置错误；
- 507 `Insufficient Storage` 服务器无法存储完成请求所必须的内容，临时的；
- 509 `Bandwidth Limit Exceeded` 服务器达到带宽限制(非官方)；
- 510 `Not Extended` 获取资源所需要的策略未被满足。