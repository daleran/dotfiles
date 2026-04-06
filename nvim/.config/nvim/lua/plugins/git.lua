-- ~/.config/nvim/lua/plugins/git.lua

return {
  -- GitHub-style diff view
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  },

  -- Inline hunk indicators in the sign column
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local opts = { buffer = bufnr }
          vim.keymap.set("n", "]h", gs.next_hunk, opts)
          vim.keymap.set("n", "[h", gs.prev_hunk, opts)
          vim.keymap.set("n", "<leader>gs", gs.stage_hunk, opts)
          vim.keymap.set("n", "<leader>gr", gs.reset_hunk, opts)
          vim.keymap.set("n", "<leader>gp", gs.preview_hunk, opts)
        end,
      })
    end,
  },
}
