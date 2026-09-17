# Rider IdeaVim 快捷键速查

这份目录保存 Rider 的 IdeaVim 配置。实际配置文件是 [`.ideavimrc`](./.ideavimrc)。

约定：

- `Space` 是 Leader 键。
- `Option` 对应 IdeaVim 配置中的 `<M-...>`。
- `Visual` 表示先使用 `v`、`V` 或 `Ctrl+v` 进入选择模式。
- 修改配置后，在 Rider 中执行 `:source ~/.ideavimrc` 重新加载。
- EasyMotion 需要同时安装并启用 **IdeaVim-EasyMotion** 和 **AceJump**。

## 基础编辑

| 快捷键 | 作用 |
| --- | --- |
| `H` | 跳到本行第一个非空字符 |
| `L` | 跳到本行末尾 |
| `Enter` | 在下方插入空行，并保持 Normal 模式 |
| `Shift+Enter` | 在上方插入空行，并保持 Normal 模式 |
| `yw` | 复制当前单词，不包含后面的空格 |
| `yW` | 复制当前 WORD，不包含后面的空格 |
| `Space y _` | 复制 `_Gloss_` 外层符号内的 `Gloss` |
| `Q` | 执行 Vim 的 `gq` 文本排版 |

## EasyMotion 跳转

| 快捷键 | 作用 |
| --- | --- |
| `Space Space s` | 输入字符，在当前可见范围内搜索并跳转 |
| `Space Space w` | 跳到前方或后方的单词开头 |
| `Space Space b` | 向前跳到单词开头 |
| `Space Space e` | 跳到前方或后方的单词结尾 |
| `Space Space f` | 输入一个字符并跳转 |
| `Space Space j` | 向下跳转到行 |
| `Space Space k` | 向上跳转到行 |
| `Space Space h` | 跳到当前行前方位置 |
| `Space Space l` | 跳到当前行后方位置 |

## Surround 包围操作

触发快捷键后继续输入包围符号，例如 `"`、`)` 或 `]`。默认的 `ys`、`ds`、`cs` 和 Visual 模式下的 `S` 仍然可用。

| 快捷键 | 作用 | 示例 |
| --- | --- | --- |
| `Space sw` | 包围当前单词，等价于 `ysiw` | `Space sw "` 给当前单词加双引号 |
| `Space ss` | 包围当前整行，等价于 `yss` | `Space ss )` 给整行加括号 |
| `Space sd` | 删除指定包围符，等价于 `ds` | `Space sd "` 删除外层双引号 |
| `Space sc` | 替换包围符，等价于 `cs` | `Space sc " '` 将双引号换成单引号 |
| Visual 后 `Space s` | 包围选中内容，等价于 `S` | 选中后按 `Space s "` |

## 多光标

| 快捷键 | 作用 |
| --- | --- |
| `Space mn` | 选中下一个完整单词匹配 |
| `Space ma` | 选中所有完整单词匹配 |
| `Space mN` | 选中下一个普通文本匹配 |
| `Space mA` | 选中所有普通文本匹配 |
| `Space mx` | 跳过当前匹配 |
| `Space mp` | 移除当前匹配 |

建立多个光标后，可以继续使用 `w`、`e`、`D`、`c`、`i` 等 Vim 操作同时编辑。

## Indentwise 缩进跳转

| 快捷键 | 作用 | 插件默认键 |
| --- | --- | --- |
| `Option+k` | 向上寻找更深缩进 | `[` `+` |
| `Option+j` | 向下寻找更浅缩进 | `]` `-` |
| `Option+u` | 向上寻找更浅缩进 | `[` `-` |
| `Option+d` | 向下寻找更深缩进 | `]` `+` |
| `Option+h` | 当前缩进块开头 | `[` `%` |
| `Option+l` | 当前缩进块结尾 | `]` `%` |

插件默认键位也保留。Indentwise 根据行首缩进量跳转；只有目标方向存在符合条件的非空行时才会移动。

## CamelCase 子单词操作

`,` 是 CamelCaseMotion 前缀，适用于 `camelCase`、`snake_case` 和 `kebab-case` 标识符。

| 快捷键 | 作用 |
| --- | --- |
| `,w` | 跳到下一个子单词 |
| `,b` | 跳到上一个子单词 |
| `,e` | 跳到当前或下一个子单词结尾 |
| `d,w` | 删除到下一个子单词 |
| `c,w` | 修改到下一个子单词 |
| `yi,w` | 复制当前子单词 |

## 代码操作

| 快捷键 | 作用 |
| --- | --- |
| `Space ff` | 格式化整个文件；Visual 模式下格式化选区 |
| `Space oi` | 优化并清理 `using` / import |
| `Space ca` | 显示意图操作和快速修复 |
| `Space rn` | 重命名当前符号 |

## 代码导航

| 快捷键 | 作用 |
| --- | --- |
| `gd` 或 `Space gd` | 跳到声明或定义 |
| `gi` 或 `Space gi` | 跳到实现 |
| `gr` 或 `Space gr` | 查找所有用法 |
| `Space gt` | 跳到对应测试 |
| `K` | 显示类型、文档等悬浮信息 |
| `Ctrl+o` | 回到上一个 Vim 跳转位置 |
| `Ctrl+i` | 前往下一个 Vim 跳转位置 |

## 文件操作

| 快捷键 | 作用 |
| --- | --- |
| `Space yf` | 复制当前文件名 |
| `Space yp` | 复制当前文件的完整路径 |
| `Space kw` | 在 Finder 中显示当前文件 |

## 分屏窗口

| 快捷键 | 作用 |
| --- | --- |
| `Space wv` | 将当前标签移动到右侧分组 |
| `Space ws` | 将当前标签移动到下方分组 |
| `Space wm` | 将当前文件移动到另一个编辑器分组 |
| `Space wc` | 关闭当前分屏 |
| `Space wo` | 合并所有分屏 |
| `Space wh` | 聚焦左侧窗口 |
| `Space wj` | 聚焦下方窗口 |
| `Space wk` | 聚焦上方窗口 |
| `Space wl` | 聚焦右侧窗口 |

## 标签页与最近文件

| 快捷键 | 作用 |
| --- | --- |
| `Space tn` | 下一个标签页 |
| `Space tp` | 上一个标签页 |
| `Space tc` | 关闭当前标签页 |
| `Space to` | 关闭除当前页之外的标签页 |
| `Space fr` | 打开最近文件列表 |
| `Space fs` | 打开 Rider Switcher |
| `Space Tab` | 打开 Rider Switcher |

## 已启用设置与插件

- 当前行显示绝对行号，其他行显示相对行号。
- 搜索时增量显示匹配结果。
- 光标上下各保留 5 行滚动空间。
- 默认使用 macOS 系统剪贴板。
- 复制内容后短暂高亮。
- 已启用 Commentary、Surround、CamelCaseMotion、Indentwise、Multiple Cursors 和 EasyMotion。
