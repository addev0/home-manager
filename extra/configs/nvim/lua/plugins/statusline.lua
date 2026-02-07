-- /lua/plugins/statusline.lua
---@type LazySpec
return {
  {
    "nvim-mini/mini.statusline",
    version = false,
    ---@type PluginOpts
    opts = {
      use_icons = true,
    },
  },
}
