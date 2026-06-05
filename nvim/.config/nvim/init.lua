-- 🛠 基础设置
vim.opt.swapfile = false             -- 禁用 swap 文件

--vim.opt.directory:prepend("~/.cache/nvim/swap//")  -- 修复 E303
vim.opt.showmode = true
vim.opt.scrolloff = 5
vim.opt.incsearch = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard:append("unnamed")

-- ⌨️ 快捷键映射
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "H", "^")
vim.keymap.set("v", "L", "$")
vim.keymap.set("v", "H", "^")

-- 🧱 Tab/缩进
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- 🌈 语法高亮
vim.cmd("syntax on")

-- 📋 Yank 高亮
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- 🎨 colorscheme 设置（含高亮修改）
vim.cmd([[
  colorscheme onedark
]])

if vim.fn.has("autocmd") == 1 and vim.fn.has("gui_running") == 0 then
  vim.api.nvim_create_augroup("colorset", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = "colorset",
    callback = function()
      local white = { gui = "#ABB2BF", cterm = "145", cterm16 = "7" }
      vim.fn["onedark#set_highlight"]("Normal", { fg = white })
    end,
  })
end

-- 1. 设置 lazy.nvim 路径并添加到 runtimepath
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2. 正确加载 lazy.nvim
require("lazy").setup("plugins")

-- Normal 模式
vim.keymap.set("n", "<D-/>", "gcc", { remap = true, desc = "Toggle comment" })

-- Visual 模式
vim.keymap.set("v", "<D-/>", "gc", { remap = true, desc = "Toggle comment (visual)" })

-- vim.keymap.set("n", "<D-/>", function()
--   print("⌘+/ pressed")
--   require("Comment.api").toggle.linewise.current()
-- end, { desc = "Toggle comment" })
