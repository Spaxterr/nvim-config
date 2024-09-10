-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local global = vim.g
local o = vim.opt

o.number = true
o.relativenumber = false
o.syntax = "on"
o.autoindent = true
o.cursorline = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.encoding = "UTF-8"
o.ruler = true
o.title = true
o.hidden = true
o.showcmd = true
o.showmatch = true
o.termguicolors = true
