-- return {
--   {
--     "MeanderingProgrammer/render-markdown.nvim",
--     opts = function(_, opts)
--       return {}
--     end,
--   },
-- }
--

return {
  -- Disable LazyVim's markdown LSP and linting
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = { enabled = false },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = {},
      },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = function()
      return {
        preset = "obsidian",
      }
    end,
    config = function(_, opts)
      require("render-markdown").setup(opts)
    end,
  },

  -- Obsidian.nvim setup
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    -- Or load only for your vault:
    -- event = {
    --   "BufReadPre " .. vim.fn.expand("~") .. "/path/to/vault/*.md",
    --   "BufNewFile " .. vim.fn.expand("~") .. "/path/to/vault/*.md",
    -- },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      -- Disable obsidian.nvim's built-in UI (render-markdown handles this)
      ui = { enable = false },

      workspaces = {
        {
          name = "main_vault",
          path = "/mnt/c/Users/jacob.scott/Obsidian/main_vault",
        },
      }, -- Recommended settings
      legacy_commands = false,

      completion = {
        blink = true, -- or blink = true if using blink.cmp
        min_chars = 2,
      },
    },
  },
}
