# docsify-file-generate-slidebar

## 使用

在docsify仓库目录建立一个新文件`.github/workflows/main.yml`，配置如下

```yaml
on: [push] # 在push的时候执行

jobs:
  add_sidebar_job:
    runs-on: ubuntu-latest
    name: job to add _sidebar.md
    steps:
      - uses: actions/checkout@v4                     # 拉取代码
      - uses: coswit/docsify-file-generate-slidebar@main # 使用action生成_sidebar.md文件并推送到仓库内
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}   # GITHUB_TOKEN 需要有写权限
          # include: '.*'
```


