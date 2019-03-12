## 跨域

前端跨域 `POST` 请求的时候，因为 `CORS（cross origin resource share）` 规范的存在，
浏览器会首先发送一次 `OPTIONS` 嗅探，同时 `header` 带 `上origin`，判断是否有跨域请求权限，
服务器响应 `access control allow origin` 的值，供浏览器与 `origin` 匹配，如果匹配则正式发送 `POST` 请求。
也就是说，如果之前开发的 `api` 没有考虑 `OPTIONS` 方法的话，`OPTIONS` 嗅探就会失败，那么跨域 `POST` 请求也会跟着失败！

## 代理

- 正向代理：正向代理隐藏了真实的请求客户端，服务端不知道真实的客户端是谁，
  客户端请求的服务都被代理服务器代替来请求，知名的科学上网工具 `shadowsocks 扮演的就是典型的正向代理角色。
  在天朝用浏览器访问 `www.google.com` 时，被残忍的拒绝了，于是你可以在国外搭建一台代理服务器，让代理帮我去请求 `google.com`，代理把请求返回的相应结构再返回给我。

- 反向代理：反向代理隐藏了真实的服务端，当我们请求 `www.baidu.com` 的时候，
  背后可能有成千上万台服务器为我们服务，但具体是哪一台，你不知道，也不需要知道，
  你只需要知道反向代理服务器是谁就好了，`www.baidu.com` 就是我们的反向代理服务器，
  反向代理服务器会帮我们把请求转发到真实的服务器那里去。

## 准备

1. 启用 `proxy` 模块
   - `Windows` 环境一般是安装了 `xampp` 或者 `wamp`。
     在 `xampp` 或者 `wamp` 安装目录下，修改 `httpd.conf` 配置文件，去掉以下两行前面 `#` 号，从而启用 `Apache proxy module`。

        ```conf
        LoadModule proxy_module modules/mod_proxy.so
        LoadModule proxy_http_module modules/mod_proxy_http.so
        ```

   - Ubuntu
    
        ```linux
        sudo apt-get install libapache2-mod-proxy-html
        sudo apt-get install libxml2-dev
        sudo a2enmod proxy proxy_http
        ```

2. 在 `httpd-vhosts.conf` 里配置 `virtualHost` 实现反向代理

    ```apcahe
    <VirtualHost *:80>
        ProxyRequests Off

        <Proxy *>
        Order deny,allow
        Allow from all
        </Proxy>

        ProxyPass /project http://ip_address/project
    </VirtualHost>
    ```

    - `ProxyRequests Off` 指令是指采用反向（`reverse`）代理
    - `ProxyPass` 指令允许将一个远端服务器映射到本地服务器的 `URL` 空间中
    - 配置完成之后，访问 `http://localhost/project` 实际就是访问 `http://ip_address/project` 上的资源

3. 重启 `Apache`