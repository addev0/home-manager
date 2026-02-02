
-- Create default capabilites
---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      telemetry = {
        enable = false,
      },
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim', }, 
      },
      workspace = {
        checkThirdParty = false,
        -- Recognize Neovim library paths.
        -- Uncomment if not using lazydev.nvim plugin
        -- library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}
