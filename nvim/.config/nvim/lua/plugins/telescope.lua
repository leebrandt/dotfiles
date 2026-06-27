return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- optional but recommended
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    vim.keymap.set("n", "<leader>fd", require("telescope.builtin").find_files)
    vim.keymap.set("n", "<leader>fg", require("telescope.builtin").git_files)
  end,
}
