### WorkFlow

>工作流，即为工作流程，为了更好的管理代码，版本迭代工作而约束的工作规范、流程。其主要是基于 “功能驱动式开发” (`Feature-driven development，简称FDD`), 指的式先有需求再有功能分支 (`feature`) 或者补丁分支 (`hotfix`) 再进行开发

#### 常见的工作流类别

- `Git Flow`
  - > 首先长期存在两个分支--- `master` (主分支) 和 `develop` (开发分支), 主分支为发布后的版本, 开发分支为日常开发使用, 保存最新的
  - > 三个临时分支--- `feature` (功能分支)、`hotfix` (补丁分支) 和 `release` (预发布分支); 开发完成后并入到开发分支
- `Github Flow`
  - > 长期分支仅为 `master` (主分支) 一个, 永远保持最新的发布版本
  - > 有版本直接无区分从主分支切出, 开发完成后提交一个 `pull request (PR)`, 当 review 或者审阅过后, 合并到主分支，立即发布, 原分支删除
- `Gitlab Flow`
  - > 其基于一个 `上游优先` 的原则, 延续 `master` (主分支) 的存在, 它是所有分支的上游分支，区别于新增了 `production` (生产分支)、`pre-production` (预发布分支), 也扩展了基于不同环境的分支; 当有功能开发或者bug修复时，从生产分支切出, 然后开发完成后合并到主分支, 最好由 `Merge` 或者 `cherry-pick` 到预发布、生产分支上
- `Trunk-based Flow`
  - > 主要有一个 `master` (主分支) 和许多发布分支组成, 每个发布分支在特定版本节点上得以创建, 进行部署和热修复; 弱化功能分支的概念, 多人同事主分支开发
- `Aone Flow`
  - > 只存在一个 `master` (主分支), 功能开发时切出功能分支 (兼容多个并行), 完成合并到主分支发布，打上 `tag`

#### 参考

- [git 使用规范](https://www.ruanyifeng.com/blog/2015/08/git-use-process.html)
- [Aone Flow](https://developer.aliyun.com/article/573549)
