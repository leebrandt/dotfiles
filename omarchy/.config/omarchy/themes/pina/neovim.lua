return {
  {
    "bjarneo/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    opts = {
      colors = {
        bg         = "#171a18",
        dark_bg    = "#121513",
        darker_bg  = "#0d0f0e",
        lighter_bg = "#252a27",

        fg         = "#d4d5d5",
        dark_fg    = "#a0a3a3",
        light_fg   = "#dedfdf",
        bright_fg  = "#eeeeee",
        muted      = "#595b5a",

        red        = "#7db085",
        yellow     = "#e0d480",
        orange     = "#aec282",
        green      = "#b8c082",
        cyan       = "#c5e8c5",
        blue       = "#7dd2b8",
        purple     = "#b5c9a4",
        brown      = "#4f6c54",

        bright_red    = "#8cc098",
        bright_yellow = "#f2e590",
        bright_green  = "#cdd590",
        bright_cyan   = "#d8f5d8",
        bright_blue   = "#92e2c8",
        bright_purple = "#c8dab8",

        accent               = "#7dd2b8",
        cursor               = "#d4d5d5",
        foreground           = "#d4d5d5",
        background           = "#171a18",
        selection            = "#252a27",
        selection_foreground = "#d4d5d5",
        selection_background = "#252a27",
      },
    },
    -- set up hot reload
    config = function(_, opts)
      require("aether").setup(opts)
      vim.cmd.colorscheme("aether")
      require("aether.hotreload").setup()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}
