


---@type vim.lsp.Config
vim.lsp.config("*", {
  root_markers = { '.git', '.hg' },
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
})

vim.diagnostic.config({
  virtual_text = {
    source = "if_many",
    prefix = '●',
  },
})

vim.lsp.enable({
  "lua_ls",
})

local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })


vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    -- Enable Inlay Hints
    -- Check if server supports
    -- if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    --   vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    -- end

    -- Enable Codelens
    --
    --
    -- Global Keymaps
    local function map(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
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

    -- Toggle Inlay Hints
    if client.server_capabilities.inlayHintProvider then
      map('<leader>th', function()
        local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
      vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = args.buf })
      end, "Toggle Inlay Hints" )
    end
  end,
})

-- on_new_config = function(new_config, root_dir)
-- end,
--     client.config.settings["*"] = vim.tbl_extend('force', client.config.settings["*"], {
--       workspace = {
--         checkThirdParty = false,
--       },
--       hint = { enable = true, semicolon = 'Disable' },
--     })
--   end,
-- }, "*")
--
--
-- --   codelens = { enable = true },
-- --   workspace = {
-- --     checkThirdParty = false,
-- --     hint = { enable = true, semicolon = "Disable" },
-- --   },
-- -- }
-- )
