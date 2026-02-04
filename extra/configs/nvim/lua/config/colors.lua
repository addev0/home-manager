local colors = {}

colors = {
  greens = {
    selection   = "#1a2b24", -- Shade 1: Deep Opaque Green
    line_bg     = "#14201b", -- Shade 2: Subtle Shadow
    ui_muted    = "#2e5e4e", -- Shade 3: Matte Forest
    neon_bright = "#42be65", -- Shade 4: The "Active" Neon
    neon_aurora = "#00ff9f", -- Shade 4: AURORA BOREALIS NEON (High Brightness)
    text_legible = "#b1f2b7", -- Shade 5: Readable text green
  },
  pinks = {
    opaque_pink = "#4d3240",
    neon_pink_opaque = "#5c2440", -- The "Opaque" base (Deep Hot Pink)
    neon_pink_bright = "#ff007c", -- The "Neon" accent for borders/numbers
    neon_pink_dim = "#aa007c", -- The "Neon" accent for borders/numbers
  },
  others = {
    very_dark_navy = "#1a1b26", -- Darker than the default Moon background
    selection_blue  = "#364a82", -- High contrast for Visual mode
    orange_accent   = "#ff9e64", -- For the line number
    teal_subtle = "#1b2b34", -- Deep, dark teal/slate
    teal_bright = "#2cf9ed", -- Your cursor/accent teal
    visual_select = "#283e4a", -- Slightly brighter for selection
    purple_dark_opaque  = "#3b224c", -- Shade 1: Selection background (Simulated 30% opacity)
    blue_bright = "#7aa2f7", -- Shade 2: Muted purple/blue for non-critical UI
    purple_bright = "#9d7cd8", -- Shade 3: The "Neon" pop (for CursorLineNr)
    purple_bright2 = "#c099ff", -- Shade 4: The brightest purple that is still readable
    selection  = "#2d1d3d", -- Deep "Crushed Grape"
    line_bg    = "#1f1a2e", -- Subtle "Midnight" highlight
    number_fg  = "#7e50d6", -- Vivid Neon (but not blinding)
    text_read  = "#b294e3", -- Legible foreground purple
  },
}

return colors
