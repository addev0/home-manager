-- nvim/after/lsp/ruff.lua

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
  cmd = { get_venv_path("ruff"), "server" },
  filetypes = { "python" },
  capabilities = capabilities,

  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ id = client.id, async = false })
      end,
    })
  end,
}

