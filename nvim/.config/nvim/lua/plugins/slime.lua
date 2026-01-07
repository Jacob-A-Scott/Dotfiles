return {
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_default_config = {
        socket_name = "default",
        target_pane = ":.2",
      }
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1

      -- Cell support
      vim.g.slime_cell_delimiter = "# %%" -- same as VSCode/Jupyter
      vim.g.slime_no_mappings = 1 -- we'll set our own
    end,
    config = function()
      -- Send cell and jump to next
      vim.keymap.set("n", "<leader>rr", function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Plug>SlimeSendCell", true, false, true), "m", false)
        vim.defer_fn(function()
          vim.fn.search("^# %%", "W")
        end, 50)
      end, { desc = "REPL: Send cell & jump to next" })
      vim.keymap.set("n", "<leader>rR", "<Plug>SlimeSendCell", { desc = "REPL: Send Cell" })
      vim.keymap.set("n", "<leader>rc", "<Plug>SlimeConfig", { desc = "REPL: Configure Slime" })
      vim.keymap.set("x", "<leader>rs", "<Plug>SlimeRegionSend", { desc = "REPL: Send Selection" })
      vim.keymap.set("n", "<leader>rl", "<Plug>SlimeLineSend", { desc = "REPL: Send Line" })
    end,
  },
}
