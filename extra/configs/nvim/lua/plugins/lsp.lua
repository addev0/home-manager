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
        on_attach = lspconfig.on_attach
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

      if opts.on_attach then
        vim.api.nvim_create_autocmd('LspAttach', opts.on_attach)
      end
    end),
  },
}
