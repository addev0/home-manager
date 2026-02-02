-- nvim/lua/plugins/lspconfig.lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",             -- load only on lua files.
        opts = {
          -- library = {
            --   { path = "luvit-meta/library", words = { "vim%.uv" } },
            -- },
        },
      },
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- Global Defaults for v0.12 nightly
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

      vim.lsp.config("*", {
        capabilities = capabilities
      })

      -- Keymaps
      local key = vim.keymap
      key.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })
      -- Enable Language-Servers
      vim.lsp.enable({
        "lua_ls",
      })
    end,
  },
}

