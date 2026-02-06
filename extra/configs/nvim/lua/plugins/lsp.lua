-- nvim/lua/plugins/lsp.lua
local lspconfig = require("config.lsp")
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      ---@class PluginLspOpts
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = lspconfig.diagnostics or {},
        servers = lspconfig.servers or {},
      }
      return ret
    end,
    config = vim.schedule_wrap(function(_, opts)
      -- Apply diagnostics
      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = function(diagnostic)
          local icons = require("config.icons").diagnostics
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
          return "●"
        end
      end
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
      -- Apply Server Config
      if opts.servers["*"] then
        vim.lsp.config("*", opts.servers["*"])
      end

      for _, server in ipairs(opts.servers) do
        if server ~= "*" then
          vim.lsp.enable(server)
        end
      end
    end),
  },
}
