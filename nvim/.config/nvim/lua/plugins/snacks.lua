return {
  "snacks.nvim",
  init = function()
    -- run on every colorscheme load (and once immediately)
    local function set_snacks_dashboard_hl()
      -- safest: link to an existing gruvbox group
      vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { link = "GruvboxYellow" })
    end

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = set_snacks_dashboard_hl,
    })

    set_snacks_dashboard_hl()
  end,
  opts = {
    dashboard = {
      preset = {
        header = [[
███╗   ██╗ ███████╗  ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
████╗  ██║ ██╔════╝ ██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
██╔██╗ ██║ █████╗   ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
██║╚██╗██║ ██╔══╝   ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
██║ ╚████║ ███████╗ ╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
╚═╝  ╚═══╝ ╚══════╝  ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
        ]],
        -- this is the key: tell snacks which highlight group to use
        hl = "SnacksDashboardHeader",
      },
    },
  },
}
