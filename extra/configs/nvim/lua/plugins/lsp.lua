-- nvim/lua/plugins/lspconfig.lua
local config_icons = require("config.icons")
return {
  {
    "neovim/nvim-lspconfig",
    -- dependencies = { "folke/lazydev.nvim", opts = {} },
    -- event = { "BufReadPost", "BufNewFile" },
    opts = function()
      ---@class PluginLspOpts
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          virtual_text = {
            source = "if_many",
            prefix = "icons",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = config_icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = config_icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = config_icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = config_icons.diagnostics.Info,
            },
          },
        },
      }
      return ret
    end,
    ---@param opts PluginLspOpts
    config = vim.schedule_wrap(function (_, opts)

      -- diagnostics
      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = function(diagnostic)
          local icons = config_icons.diagnostics
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
          return '●'
        end
      end

      -- Apply diagnostics
      vim.diagnostic.config(opts.diagnostics)
    end),
  },
}
