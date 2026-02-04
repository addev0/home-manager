-- /lua/config/lsp.lua
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

-- This defines the "Dry/Standard" colors. It needs to run whenever the colorscheme loads.
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    -- Your specific styling
    vim.api.nvim_set_hl(0, 'LspHoverNormal', { bg = '#1f1f1f', fg = '#dcdcdc' })
    vim.api.nvim_set_hl(0, 'LspHoverBorder', { fg = '#808080', bg = '#1f1f1f' })
    vim.api.nvim_set_hl(0, 'LspReferenceTarget', {})
  end,
})

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

    -- We define the function here so it uses your specific style settings
    -- 3. HOVER POPUP (K)
    local function hover_fixed()
      vim.lsp.buf.hover({
        border = 'rounded',
        focusable = true,
        -- We map all common syntax groups to 'LspHoverNormal' to strip the colors
        winhighlight = table.concat({
          'Normal:LspHoverNormal',
          'FloatBorder:LspHoverBorder',
          'EndOfBuffer:LspHoverNormal',

          -- Mute the colors by mapping them to your standard text color
          'Comment:LspHoverNormal',
          'Constant:LspHoverNormal',
          'String:LspHoverNormal',
          'Identifier:LspHoverNormal',
          'Function:LspHoverNormal',
          'Statement:LspHoverNormal',
          'Keyword:LspHoverNormal',
          'Type:LspHoverNormal',
          'Operator:LspHoverNormal',
          'Special:LspHoverNormal',

          -- Handle Treesitter specific groups (if you use Treesitter)
          '@variable:LspHoverNormal',
          '@function:LspHoverNormal',
          '@keyword:LspHoverNormal',
          '@type:LspHoverNormal',
        }, ','),

        winblend = 0,
      })
    end
    -- If your 'map' function supports a buffer option, use it. 
    -- Otherwise, the standard way inside LspAttach is vim.keymap.set:
    vim.keymap.set('n', 'K', hover_fixed, { buffer = args.buf, desc = "Hover" })

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
