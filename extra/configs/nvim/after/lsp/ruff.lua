-- nvim/after/lsp/ruff.lua

local function get_venv_path(bin_name)
  local path = vim.fn.getcwd() .. "/.venv/bin/" .. bin_name
  return vim.fn.executable(path) == 1 and path or bin_name
end

---@type vim.lsp.Config
return {
  cmd = { get_venv_path("ruff"), "server" },

  filetypes = { "python" },

  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
}

