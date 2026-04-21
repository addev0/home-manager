-- /after/ftplugin/typescript.lua
if vim.bo.filetype ~= "ts" then
    return
end

local opt = vim.opt_local
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
