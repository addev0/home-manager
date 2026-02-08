-- /lua/plugins/statusline.lua
---@type LazySpec
return {
  {
    "nvim-mini/mini.statusline",
    version = false,
    ---@type PluginOpts
    dependencies = {
      {
        "nvim-mini/mini.icons",
        version = false,
        opts = {},
        -- config = function()
        --   require("mini.icons").setup()
        -- end,
      },
    },
    opts = {
      use_icons = true,
      set_vim_settings = false, -- Optinoal: prevents overwriting global statusline.
    },
    -- config = function()
    --
    -- end,
  },
}
