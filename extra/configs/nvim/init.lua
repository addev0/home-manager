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

if vim.g.vscode then
  local ok, vscode = pcall(require, "vscode")
  if ok and vscode then
    vim.notify = vscode.notify
  else
    vim.notify(("Failed loading vscode module: %s"):format(vscode or "nil"),
    vim.log.levels.WARN)
  end

  vim.notify("Loading VSCode Neovim Config...", vim.log.levels.INFO, { title = "VSCode Neovim" })

  require("config.vsvim")
  return
end

-- ###############################
--      GLOBAL OPTIONS
-- ===============================
require("config.options")

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

vim.opt.guicursor = "n-v-c:block-Cursor-blinkwait700-blinkoff400-blinkon250,i-ci-ve:ver25-Cursor-blinkwait700-blinkoff400-blinkon250,r-cr-o:hor20-Cursor-blinkwait700-blinkoff400-blinkon250"
require("config.cursormode").setup()
