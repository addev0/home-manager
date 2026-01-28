return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",

        config = function()
            local ts = require("nvim-treesitter")

            ts.setup()
            
            -- Checks and installs specified language-parsers asynchronously
            ts.install({
                -- Essentials
                "lua", "luadoc", "vim", "vimdoc", "query",
                -- Shell & System
                "bash", "diff", "regex",
                -- C Family
                "c", 
                -- Lisp Family
                "commonlisp",
                -- Web & Data
                "markdown", "markdown_inline", "html",
                "json", -- "jsonc" (deprecated),
                -- Scripting
                "nix", "powershell",
                "yaml",
            })

            -- Autocmd that starts nvim-treesitter in File-Open
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end
            })
        end,
    },
}
