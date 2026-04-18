-- nvim/after/lsp/pyright.lua

local function get_venv_path(bin_name)
  local path = vim.fn.getcwd() .. "/.venv/bin/" .. bin_name
  return vim.fn.executable(path) == 1 and path or bin_name
end

---@type vim.lsp.Config
return {
  cmd = { get_venv_path("pyright-langserver"), "--stdio" },

  settings = {
    python = {
      pythonPath = get_venv_path('python'),
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
      },
    },
  },
}
