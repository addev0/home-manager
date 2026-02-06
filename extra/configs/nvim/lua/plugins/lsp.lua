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
