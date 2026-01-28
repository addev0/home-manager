return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- branch = "main",
        version = false,
        lazy = false, -- Lazy load was removed to improve startup time.
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        keys = {
            -- Modern keys for incremental selection
            { "<C-space>", desc = "Incremental Selection" },
            { "<BS>", desc = "Decremental Selection", mode = "x" },
        },
        --@type TSConfig
        opts = {
            ensure_installed = {
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
                "json", "jsonc",
                -- Scripting
                "nix", "powershell",
                "yaml",
            },
            auto_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<BS>",
                },
            },
        },
        -- Config function that apply options.
        config = function(_, opts)
            -- vim.opt.rtp:prepend(opts.parser_install_dir)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
