
vim.g.mapleader = " "
vim.g.maplocalleader = " "


vim.notify("Loading Config: /config/vsvim.lua", vim.log.levels.INFO, { title = "VSCode Neovim" })
local vscode = vim.g.vscode and require("vscode") or nil

-- VSCode Neovim Extension Settings
-- Clipboard Settings Sync with wl-clipboard
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)
-- vim.opt.clipboard:append("unnamedplus")

vim.opt.backspace = "indent,eol,start"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.sidescrolloff = 0
vim.opt.scrolloff = 8

local mappings = {
    { "n", "<leader>gd", "editor.action.revealDefinitionAside" },
    { "n", "<leader>gD", "editor.action.revealDeclaration" },
    { "n", "<leader>gi", "editor.action.goToImplementation" },
    { "n", "<leader>gr", "editor.action.referenceSearch.trigger" },
    { "n", "<leader>gt", "editor.action.goToTypeDefinition" },
    { "n", "<leader>gs", "editor.action.signatureHelp" },
    { "n", "<leader>rn", "editor.action.rename" },
    { "n", "<leader>ca", "editor.action.quickFix" },
}

for _, mapping in ipairs(mappings) do
    local mode, key, command = unpack(mapping)
    vim.keymap.set(mode, key, function()
        vscode.action(command)
    end, { desc = "VSCode Action: " .. command })
end

local colors = require("config.colors")
vim.api.nvim_set_hl(0, "YankHighlight", { bg = colors.teal.muted, bold = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    callback = function()
        vim.hl.on_yank({
            higroup = "YankHighlight",
            timeout = 300,
        })
        -- vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})


vim.opt.guicursor = "n-v-c:block-Cursor-blinkwait700-blinkoff400-blinkon250,i-ci-ve:ver25-Cursor-blinkwait700-blinkoff400-blinkon250,r-cr-o:hor20-Cursor-blinkwait700-blinkoff400-blinkon250"
require("config.cursormode").setup()

local vscode = vim.g.vscode and require("vscode") or nil
vim.print(vscode)
vscode.action("editor.action.showImplementations")