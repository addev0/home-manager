vim.notify("Loading Config: /config/vsvim.lua", vim.log.levels.INFO, { title = "VSCode Neovim" })

-- VSCode Neovim Extension Settings
-- Clipboard Settings Sync with wl-clipboard
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)
-- vim.opt.clipboard:append("unnamedplus")

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true

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