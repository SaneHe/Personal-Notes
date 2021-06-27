### [Jenkins](https://github.com/jenkinsci/docker)

### 安装步骤

    1. 若需要，可以修改项目目录下的 `.env` 文件
    2. 项目目录下启动 `jenkins` 执行命令 `docker-compose up [-d] jenkins`
    3. 浏览器打开 `http://127.0.0.1:8081` (默认端口) 即可访问
    4. 浏览器中打开需要输入管理员密码，需要进入容器
       1. 可以使用 `docker ps ` 查看当前容器信息
       2. 使用 `docker exec -it jenkins sh` 进入容器 (exec 在容器中执行命令 -t 分配一个终端 -t 即使没有附加也保持STDIN 打开 sh 执行容器的 sh命令)
       3. 查看管理员密码 `cat /var/jenkins_home/secrets/initialAdminPassword` 复制、黏贴即可
    5. 当前目录下的 `data` 目录为容器内挂载目录，可查看相关信息
    6. `docker-compose up|start|stop|restart|build|rm 容器` 启动并创建|启动|停止|重启|构建|删除

### tips

> 若进入容器内后发现缺少命令以及工具可以使用 `apk` 命令安装 (add|del)

### jenkins

```bash
http://127.0.01:8081/
用户名 sane
密码 sane 
jenkins
```

### 跨服务器

- geek
  - ssh-keygen -f jenkins
  - cat ~/.ssh/jenkins.pub
  - 然后将 密钥加入到 test、preview 服务器的 ~/.ssh/authorized_keys 文件中
  - 将 jenkins 服务器私钥复制到 =》 进入Jenkins平台，点击 系统管理 -> 系统设置 -> 找到 Publish Over SSH 配置项
