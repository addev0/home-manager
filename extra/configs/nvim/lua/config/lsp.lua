-- /lua/config/lsp.lua
local icons = require("config.icons")

return {
  on_attach = {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client then return end
      -- Enable Inlay Hints
      -- if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      --   vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      -- end
      local function map(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
      end
      map('<leader>cd', function()
        vim.diagnostic.open_float({
          focus = true,       -- automatically enters the window.
          focusable = true,   -- allows to enter the window
          scope = 'line',      -- show all diagnostics on the current, line
          border = 'rounded',
          source = 'if_many',
          header = 'Diagnostics',
        })
      end, "Show Full Diagnostic (Scrollable)")
    end,
  },
  servers = {
    ["*"] = {
      keys = {},
    },
    "lua_ls",
    "nixd",
    -- vscode-langsrevers-extracted
    "html",
    "cssls",
    "jsonls",
    "ts_ls",
    "eslint",
    -- Python
    "pyright",
    "ruff",
    -- Clang
    "clangd"
  },
  ---@type vim.diagnostic.Opts
  diagnostics = {
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      -- prefix = "●",
      -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
      prefix = function(diagnostic)
        local diag_icons = require("config.icons").diagnostics
        for d, icon in pairs(diag_icons) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
        return "●"
      end,
    },
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
      },
    },
  },
}

