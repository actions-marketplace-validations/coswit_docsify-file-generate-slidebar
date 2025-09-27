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



## Usage

### Example Workflow file

```yml copy
on: [push]

jobs:
  add_sidebar_job:
    runs-on: ubuntu-latest
    name: job to add _sidebar.md
    steps:
      - uses: actions/checkout@v4
      - uses: if-nil/docsify-file-catalog-action@main
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          # include: '.*'
```

| inputs | description | required | default |
| --- | --- | --- | --- |
| github_token | Used to add `_sidebar.md` to the repository, requires write access. | true | null |
| include | Files what you want the directory to contain. Use regular expressions. | false | `.*\.md` |

## Example

You can see the usage inside this repository 
[actions-demo](https://github.com/if-nil/actions-demo)

``` md
- [README.md](./README.md)
- directory1
  - [file1.1.md](./directory1/file1.1.md)
  - [file1.md](./directory1/file1.md)
- directory2
  - [file2.md](./directory2/file2.md)
- directory3
  - [file3.md](./directory3/file3.md)
- [_sidebar.md](./_sidebar.md)

```
_contents of the `_sidebar.md`_