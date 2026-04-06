-- ~/.config/nvim/lua/plugins/database.lua

return {
  {
    "tpope/vim-dadbod",
    lazy = true,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = "tpope/vim-dadbod",
    cmd = { "DBUI", "DBUIToggle" },
    config = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
