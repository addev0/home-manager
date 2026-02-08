-- ###############################
--      GLOBAL OPTIONS
-- ===============================

local vim_opts = {
  expandtab = true,
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
  autoindent = true,
  smartindent = false,                    -- ALWAYS Disable: Dumb logic
  breakindent = true,
  -- breakindentopt = "shift:2",
  linebreak = true,
  termguicolors = true,
  number = true,
  relativenumber = true,
  signcolumn = "yes:1",
  wrap = false,
  undofile = true,
  swapfile = false,
  mouse = 'a',
  showtabline = 1,
  scrolloff = 8,
  sidescrolloff = 0,
  cursorline = true,
  showmode = false,
}
for key, value in pairs(vim_opts) do
  vim.opt[key] = value
end

vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

vim.g.netrw_liststyle = 3
