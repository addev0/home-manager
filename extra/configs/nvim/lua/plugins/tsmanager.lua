return {
  {
    "romus204/tree-sitter-manager.nvim",
    dependencies = { "tree-sitter/tree-sitter" },
    branch = "main",
    lazy = false,

    config = function()
      local tsm = require("tree-sitter-manager")

      tsm.setup({
        install = {
          -- Essentials
          "lua", "luadoc", "vim", "vimdoc", "query",
          -- Shell & System
          "bash", "diff", "regex",
          -- C Family
          "c",
          -- Lisp Family
          "commonlisp",
          -- Web & Data
          "markdown", "markdown_inline", "html", "html_tags",
          "json", -- "jsonc" (deprecated),
          -- Scripting
          "nix", "powershell",
          "yaml",
        },
      })

      -- Checks and installs specified language-parsers asynchronously

      -- Autocmd that starts nvim-treesitter in File-Open
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
            pcall(vim.treesitter.start)
        end
      })
    end,
  },
}
