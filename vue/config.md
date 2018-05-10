## 配置 ##

- 临时使用

```
npm --registry https://registry.npm.taobao.org install express
```

- 持久使用

```
npm config set registry https://registry.npm.taobao.org
```

## 全局安装 vue-cli ##

```
1. npm install --global vue-cli
2. vue init webpack my-project      # 创建一个基于 webpack 模板的新项目
3. cd my-project
4. npm install                      # 安装依赖
5. npm run dev
```
