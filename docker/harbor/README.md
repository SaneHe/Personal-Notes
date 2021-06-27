
- `wget https://github.com/goharbor/harbor/releases/download/v2.3.0/harbor-offline-installer-v2.3.0.tgz`
- `tar xzvf ./harbor-offline-installer-v2.3.0.tgz ./harbor`
- `cd harbor && cp harbor.yml.tmpl harbor.yml`
- `vim harbor.yml` 配置参数
- `./prepare`
- `./install.sh`
