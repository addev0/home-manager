
local CursorMode = {}

local colors = require("config.colors")
local defaults = {
  mode_colors = {
    -- Normal Mode
    n = colors.teal.neon,
    no = colors.teal.neon,
    nov = colors.teal.neon,
    noV = colors.teal.neon,
    ["no\22"] = colors.teal.neon,
    -- Insert Mode
    i = colors.green.neon_dim,
    ic = colors.green.neon_dim,
    ix = colors.green.neon_dim,
    -- Visual
    v = "#bb9af7",
    V = "#bb9af7",
    ["\22"] = "#bb9af7",

    -- Select modes
    s = "#ff9e64",
    S = "#ff9e64",
    ["\19"] = "#ff9e64",

    -- Command mode
    c = "#e0af68",
    cv = "#e0af68",
    ce = "#e0af68",

    -- Replace modes
    R = "#f7768e",
    Rv = "#f7768e",
    Rx = "#f7768e",

    -- Terminal mode
    t = "#73daca",
    ["!"] = "#73daca",
  },
}

function CursorMode.setup(user_opts)
  -- user_opts = user_opts or {}
  -- Links user_opts and defaults
  -- setmetatable(user_opts, { __index = defaults })
  CursorMode.config = vim.tbl_deep_extend("force", defaults, user_opts or {})

  local function update_cursor_colors()
    local mode = vim.fn.mode()
    local color = CursorMode.config.mode_colors[mode] or colors.teal.neon

    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = color, bold = true })
    vim.api.nvim_set_hl(0, "Cursor", { bg = color, fg = "#000000" })
  end

  local group = vim.api.nvim_create_augroup("cursor-mode-colors", { clear = true })

  vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = update_cursor_colors,
    desc = "Update cursor colors on mode change",
    group = group,
  })

  update_cursor_colors()
end

return CursorMode


