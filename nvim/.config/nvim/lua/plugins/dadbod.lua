return {
  {
    "tpope/vim-dadbod",
    lazy = true,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_save_location = vim.fn.stdpath("config") .. "/db_ui"
    end,
    keys = {
      { "<leader>D", "<cmd>DBUIToggle<CR>", desc = "DB UI Toggle" },
    },
  },
}
