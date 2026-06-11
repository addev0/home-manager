-- /after/indent/python.lua

local opt = vim.opt_local
opt.indentexpr = ""
opt.smartindent = false
opt.cindent = false

opt.autoindent = true

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
