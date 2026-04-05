if vim.bo.filetype ~= "nix" then
  return
end

local opt = vim.opt
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
