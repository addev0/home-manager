if vim.bo.filetype ~= "python" then
    return
end

vim.bo.indentexpr = ""

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.indentexpr = ""
  end,
})

local opt = vim.opt_local
opt.smartindent = false
opt.cindent = false

opt.autoindent = true
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
