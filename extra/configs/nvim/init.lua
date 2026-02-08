-- /init.lua
-- ###############################
--      LEADER MAPPING
-- ===============================
-- Ensure Leader Keys aren't mapped.
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true, noremap = true })
-- Remap leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- ===============================

-- ###############################
--      OPTIONS
-- ===============================
local vim_opts = {
  expandtab = true,
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
  autoindent = true,
  smartindent = false,          -- ALWAYS Disable: Dumb logic
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
}
for key, value in pairs(vim_opts) do
  vim.opt[key] = value
end

-- Apply these after loading your colorscheme
--

vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

vim.g.netrw_liststyle = 3
-- ===============================

-- ===============================


-- ###############################
--      Import Modules
-- ===============================
-- Setup
require("config.lazy")
local colors = require("config.colors")
-- ===============================

-- ###############################
--      COLORSCHEMES
-- ===============================
-- Preferred Colorscheme
local pref_colo = "tokyonight-moon"
local ok, _ = pcall(function()
  vim.cmd("colorscheme " .. pref_colo)
end)
if not ok then
  print("Theme '" .. pref_colo .. "' not found. loading fallback...")
  -- Fallback
  vim.cmd("colorscheme unokai")
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

-- ===============================
-- Apply these after loading tokyonight-moon

-- 1. The subtle dark navy for the current line
vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.others.very_dark_navy })
-- 2. The brighter blue for Visual selection (to distinguish from CursorLine)
vim.api.nvim_set_hl(0, "Visual", { bg = colors.teal.subtle, bold = true })
-- 3. The line number remains vibrant to guide your eyes
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.teal.bright, bold = true })
vim.api.nvim_set_hl(0, "YankHighlight", { bg = colors.teal.muted, bold = true })

-- ###############################
--      AUTOCOMMANDS
-- ===============================
-- Sync System-Clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
-- Text Yank Post
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('custom-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank({
      higroup = "YankHighlight",
      timeout = 300,
    })
  end,
})
--
-- ===============================
-- vim.lsp.enable({
  --   "lua_ls"
  -- })
  --
require("config.cursormode").setup()
