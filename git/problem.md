### `this exceeds GitHub's file size limit of 100.00 MB`

> - git filter-branch --force --index-filter "git rm --cached --ignore-unmatch (大文件路径 多个空格即可)"  --prune-empty --tag-name-filter cat -- --all
> - git commit --amend -CHEAD  # 修改提交
> - git push origin master  # 推送
