-- nvim/after/lsp/pyright.lua

local function get_venv_path(bin_name)
  local path = vim.fn.getcwd() .. "/.venv/bin/" .. bin_name
  return vim.fn.executable(path) == 1 and path or bin_name
end

local base_caps = vim.lsp.protocol.make_client_capabilities()

local capabilities = vim.tbl_deep_extend("force", base_caps, {
  offsetEncoding = { "utf-16" },
  general = {
    positionEncodings = { "utf-16" },
  },
})

---@type vim.lsp.Config
return {
  cmd = { get_venv_path("pyright-langserver"), "--stdio" },
  capabilities = capabilities,

  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,

  settings = {
    python = {
      pythonPath = get_venv_path('python'),
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
        diagnosticMode = "openFilesOnly"
      },
    },
  },
}
