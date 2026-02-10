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
    "html",
    "cssls",
    "ts_ls",
    "jsonls",
    "eslint",
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

--
--
-- vim.lsp.enable({
--   "lua_ls",
-- })
-- ---@type vim.lsp.Config
-- vim.lsp.config("*", {
--   root_markers = { '.git', '.hg' },
--   capabilities = {
--     textDocument = {
--       semanticTokens = {
--         multilineTokenSupport = true,
--       },
--     },
--   },
-- })
--
-- vim.diagnostic.config({
--   virtual_text = {
--     source = "if_many",
--     prefix = '●',
--     severity_sort = true,
--   },
--   signs = {
--     text = {
--       [vim.diagnostic.severity.ERROR] = '',
--       [vim.diagnostic.severity.WARN] = '',
--     },
--     linehl = {
--       [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
--     },
--     numhl = {
--       [vim.diagnostic.severity.WARN] = 'WarningMsg',
--     },
--   },
-- })
--
--
-- -- -- This defines the "Dry/Standard" colors. It needs to run whenever the colorscheme loads.
-- -- vim.api.nvim_create_autocmd('ColorScheme', {
-- --   callback = function()
-- --     -- Your specific styling
-- --     vim.api.nvim_set_hl(0, 'LspHoverNormal', { bg = '#1f1f1f', fg = '#dcdcdc' })
-- --     vim.api.nvim_set_hl(0, 'LspHoverBorder', { fg = '#808080', bg = '#1f1f1f' })
-- --     vim.api.nvim_set_hl(0, 'LspReferenceTarget', {})
-- --   end,
-- -- })
--
-- local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })
--
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = lsp_group,
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if not client then return end
--
--     -- Enable Inlay Hints
--     -- Check if server supports
--     -- if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
--     --   vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
--     -- end
--
--     -- Enable Codelens
--     --
--     --
--     -- Global Keymaps
--     local function map(keys, func, desc)
--       vim.keymap.set('n', keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
--     end
--
--
--
--     map('<leader>cd', function()
--       vim.diagnostic.open_float({
--         focus = true,       -- automatically enters the window.
--         focusable = true,   -- allows to enter the window
--         scope = 'line',      -- show all diagnostics on the current, line
--         border = 'rounded',
--         source = 'if_many',
--         header = 'Diagnostics',
--       })
--     end, "Show Full Diagnostic (Scrollable)")
--
--     -- Toggle Inlay Hints
--     if client.server_capabilities.inlayHintProvider then
--       map('<leader>th', function()
--         local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
--       vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = args.buf })
--       end, "Toggle Inlay Hints" )
--     end
--
--     -- We define the function here so it uses your specific style settings
--     -- 3. HOVER POPUP (K)
--     local function hover_fixed()
--       vim.lsp.buf.hover({
--         border = 'rounded',
--         focusable = true,
--         winblend = 0,
--       })
--     end
--     -- If your 'map' function supports a buffer option, use it. 
--     -- Otherwise, the standard way inside LspAttach is vim.keymap.set:
--     map('K', hover_fixed, "Hover" )
--
--   end,
-- })
--
-- -- on_new_config = function(new_config, root_dir)
-- -- end,
-- --     client.config.settings["*"] = vim.tbl_extend('force', client.config.settings["*"], {
-- --       workspace = {
-- --         checkThirdParty = false,
-- --       },
-- --       hint = { enable = true, semicolon = 'Disable' },
-- --     })
-- --   end,
-- -- }, "*")
-- --
-- --
-- -- --   codelens = { enable = true },
-- -- --   workspace = {
-- -- --     checkThirdParty = false,
-- -- --     hint = { enable = true, semicolon = "Disable" },
-- -- --   },
-- -- -- }
-- -- )
