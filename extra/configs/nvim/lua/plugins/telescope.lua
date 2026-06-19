---@type LazySpec

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")

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
      { '<leader>ff', function() builtin.find_files() end, desc = 'Telescope: Find files' },
      { '<leader>fF', function() builtin.find_files({ no_ignore = true }) end, desc = 'Telescope: Find files (include ignore)' },

      { '<leader>Ff', function() builtin.find_files({ hidden = true }) end, desc = 'Telescope: Find files (includes hidden)' },
      { '<leader>FF', function() builtin.find_files({ hidden = true, no_ignore = true }) end, desc = 'Telescope: Find files (includes hidden + ignore)' },

      { '<leader>fp', function() builtin.find_files({ search_dirs={ ".." } }) end, desc = 'Telescope: Find Files (Parent)' },
      { '<leader>fP', function() builtin.find_files({ search_dirs={ ".." }, no_ignore = true }) end, desc = 'Telescope: Find Files on Parent (includes ignore)' },

      { '<leader>Fp', function() builtin.find_files({ search_dirs = { ".." }, hidden = true }) end, desc = 'Telescope: Find Files on Parent (include hidden)' },
      { '<leader>FP', function() builtin.find_files({ search_dirs = { ".." }, hidden = true, no_ignore = true }) end, desc = 'Telescope: Find Files on Parent (include hidden + ignore)' },

      { '<leader>fg', function() builtin.live_grep() end, desc = 'Telescope: Grep String (Live)' },

      { '<leader>fs', function() builtin.grep_string() end, desc = 'Telescope Grep Word under Cursor' },

      { '<leader>fb', function() builtin.buffers() end, desc = 'Telescope: Find Buffers' },
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

    mappings = {
      i = {
        ["<C-e>"] = function(prompt_bufnr)
          local picker = actions_state.get_current_picker(prompt_bufnr)
          local filepath = picker:_get_promopt()

          actions.close(prompt_bufnr)

          if filepath == "" then
            return
          end

          vim.cmd("edit " .. vim.fn.fnameescape(filepath))
        end,
      },
    },
  },
}
