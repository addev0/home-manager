-- nvim/lua/plugins/lsp.lua
local lspconfig = require("config.lsp")
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      ---@class PluginLspOpts
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = lspconfig.diagnostics or {},
        servers = lspconfig.servers or {},
        on_attach = lspconfig.on_attach,
        capabilities = capabilities,
      }
      return ret
    end,

    config = vim.schedule_wrap(function(_, opts)
      -- Apply diagnostics
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- -- Apply Server Config
      -- if opts.servers["*"] then
      --   vim.lsp.config("*", opts.servers["*"])
      -- end

      local global_opts = vim.tbl_deep_extend("force", opts.servers["*"] or {}, {
        capabilities = opts.capabilities
      })
      vim.lsp.config("*", global_opts)

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
