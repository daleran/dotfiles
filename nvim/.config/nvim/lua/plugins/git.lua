-- ~/.config/nvim/lua/plugins/git.lua

return {
  -- GitHub-style diff view
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        keymaps = {
          -- `gR` ("go Review"): pop the file under the cursor out of the diff
          -- into a full-screen tab at the same line, ready to drop a
          -- `// REVIEW:` marker for the address-reviews workflow.
          view = {
            { "n", "gR", actions.goto_file_tab, { desc = "Open file full-screen at this line (REVIEW)" } },
          },
          file_panel = {
            { "n", "gR", actions.goto_file_tab, { desc = "Open file full-screen at this line (REVIEW)" } },
          },
        },
      })
    end,
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

  -- GitHub PR review inside Neovim
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Octo" },
    config = function()
      require("octo").setup({
        use_local_fs = true,
        enable_builtin = true,
        picker = "telescope",
      })
    end,
  },
}
