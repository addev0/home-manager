-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

---@type vim.lsp.Config
return {
  -- capabilities = capabilities,
  settings = {
    html = {
      format = {
        templating = true,            -- Prevents formatter from messing up django/jinja/go templates
        wrapLineLength = 120,         -- Wraps Line at 120 (set to 0 to turn off)
        wrapAttributes = 'auto',      -- options: auto, force, force-aligned, preserve
        indentInnerHtml = true,       -- Indent <head> and <body> section
        unformatted = {               -- Tags that should never be formatted
          'pre', 'code', 'textarea'
        },
      },
      -- Hover documentation
      hover = {
        documentation = true,
        references = true,
      },
      -- Enable/Disable validation (scripts/styles only)
      validate = {
        scripts = true,
        styles = true,
      },
    },
  },
  -- })
-- end,
}

