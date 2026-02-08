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
        config = function()
          require("mini.icons").setup()
          require("mini.icons").mock_nvim_web_devicons()
        end,
      },
    },
    opts = {
      use_icons = true,
      set_vim_settings = false, -- Optinoal: prevents overwriting global statusline.
    },
  },
}
