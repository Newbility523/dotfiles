-- init.lua: Lazy.nvim bootstrap + user settings

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic options
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"

vim.opt.showmode = true
vim.opt.scrolloff = 5
vim.opt.incsearch = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard:append("unnamed")
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.cmd("syntax on")

-- Mappings
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "H", "^")
vim.keymap.set("v", "L", "$")
vim.keymap.set("v", "H", "^")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Colorscheme (use default or install one yourself)
vim.cmd([[colorscheme default]])

-- Setup Lazy
require("lazy").setup("plugins")
