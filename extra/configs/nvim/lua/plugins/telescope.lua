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
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Telescope: Find files." },
    },
  },
}
