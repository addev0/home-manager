---@type LazySpec
return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    ---@type LazyKeysSpec[]
    keys = {
      { '<leader>fh', "<cmd>Telescope find_files hidden=true<CR>", desc = 'Telescope: Find files (include hidden)' },
      { '<leader>ff', "<cmd>Telescope find_files<CR>", desc = 'Telescope: Find files' },
      { '<leader>fg', "<cmd>Telescope live_grep<CR>", desc = 'Telescope: Grep String (Live)' },
      { '<leader>fs', "<cmd>Telescope grep_string<CR>", desc = 'Telescope Grep Word under Cursor' },
      { '<leader>fb', "<cmd>Telescope buffers<CR>", desc = 'Telescope: Find Buffers' },
    },

    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          -- Appearance and behavior
          path_display = { "truncate" },
          file_ignore_patterns = { "node_modules", ".git/" },
        },
      })
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
