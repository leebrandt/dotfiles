return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Octo",
  opts = {
    enable_builtin = true,
    default_merge_method = "squash",
  },
  keys = {
    { "<leader>oi", "<cmd>Octo issue list<CR>", desc = "Issues (Octo)" },
    { "<leader>oI", "<cmd>Octo issue search<CR>", desc = "Search Issues (Octo)" },
    { "<leader>op", "<cmd>Octo pr list<CR>", desc = "PRs (Octo)" },
    { "<leader>oP", "<cmd>Octo pr search<CR>", desc = "Search PRs (Octo)" },
  },
}
