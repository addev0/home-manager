return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = function(_, opts)
          local teal = require("config.colors").teal
          local green = require("config.colors").green
            -- opts.auto_integrations = true
            -- Your existing options (style, transparent, etc.)
            opts.style = "moon" -- or "moon", "night", "day", "storm"
            opts.transparent = true
            -- This function allows you to override specific highlights
            opts.on_highlights = function(hl, c)
                -- 'c' is the color palette of tokyonight (c.cyan, c.bg, etc.)
                -- Set the Cursor:
                -- bg: We use c.cyan (a nice cyanic blue)
                -- fg: We use c.bg (the dark background color) to make the text inside readable
                -- hl.Cursor = { bg = c.cyan, fg = c.bg }
                hl.Cursor = { bg = "#00ffff", fg = "#000000" }

                -- init.lua's 'TextYankPost'
                hl.YankColor = { bg = "#005555", fg = c.fg }
                -- Optional: Different color for Insert Mode?
                -- hl.CursorInsert = { bg = c.blue, fg = c.bg } 

                -- MiniStatusLine
                hl.MiniStatuslineModeNormal = { bg = teal.neon, fg = c.black, bold = true }
                hl.MiniStatuslineModeInsert = { bg = green.neon_dim, fg = c.black, bold = true }
            end
            return opts
        end,
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight-moon")
            vim.opt.guicursor = "n-v-c:block-Cursor-blinkwait700-blinkoff400-blinkon250,i-ci-ve:ver25-Cursor-blinkwait700-blinkoff400-blinkon250,r-cr-o:hor20-Cursor-blinkwait700-blinkoff400-blinkon250"
            vim.opt.termguicolors = true
        end
    },
}





























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

