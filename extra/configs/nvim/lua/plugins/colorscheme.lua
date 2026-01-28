
return {
    -- {
    --     "EdenEast/nightfox.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = function(_, opts)
    --         opts.transparent = true
    --         -- opts.auto_integrations = true
    --         -- opts.transparent_background = true
    --     end,
    --     config = function(_, opts)
    --         require("nightfox").setup(opts)
    --         -- vim.cmd.colorscheme("nightfox")  
    --     end
    -- },
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     lazy = false,
    --     priority = 1000,
    --     opts = function(_, opts)
    --         opts.auto_integrations = true
    --         opts.transparent_background = true
    --     end,
    --     config = function(_, opts)
    --         require("catppuccin").setup(opts)
    --         -- vim.cmd.colorscheme("catppuccin-mocha")
    --     end
    -- },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = function(_, opts)
            -- opts.auto_integrations = true
            opts.transparent = true
        end,
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight-moon")
        end
    }, 
}
