# 剧本处理

前置条件：需要安装 Air SDK，并将 [DB Copy](https://github.com/probertson/air-sqlite/tree/DB-copy-dev/src) 复制到当前目录。

## 解包、打包使用方式

将 `text.dat` 放入此文件夹，即可。

编译解包代码为 SWF：`mxmlc Document.as`，编译打包代码为 SWF：`mxmlc Pack.as`。

解包或打包 SWF 编译好之后，修改 `applicaton.xml` 中的 `application` 标签中的 `xmlns` 为对应你打包好 SWF 的版本，将 `content` 中的文件名换成打包好的文件名，阅读下文的其他要求，运行 `adl application.xml` 即可。

### 重打包要求

将翻译好的 `.xml` 放入本文件夹下，即可。

## 格式转换

需要 Python 3.10+ 和 `openpyxl` 包。

将原文 `.xml` 放入本文件夹下，即可。

1. 将 XML 剧本转换为 Excel 表格：`python xml_to_excel.py`
2. 将 Excel 表格转换为 XML 剧本：`python excel_to_xml.py`（仅自动处理缩进）
3. 将 XML 剧本转换为按章节分类的 Markdown 文本：`python xml_to_md.py`
