


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
--      COLORSCHEMES
-- ===============================
-- Preferred Colorscheme
local pref_colo = "tokyonight-moon"

local ok, _ = pcall(vim.cmd, "colorscheme" .. pref_colo)
if not ok then
    print("Theme '" .. pref_colo .. "' not found. loading fallback...")
    -- Fallback
    vim.cmd("colorscheme unokai")
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end
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
}
for key, value in pairs(vim_opts) do
    vim.opt[key] = value
end

vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

vim.g.netrw_liststyle = 3
-- ===============================

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
        vim.hl.on_yank()
    end,
})
-- ===============================

-- ###############################
--      LAZY.NVIM SETUP
-- ===============================
-- Setup
require("config.lazy")
