local function ic(n) return vim.fn.nr2char(n) .. " " end

return {
  {
    "folke/snacks.nvim",
    init = function()
      local function hl()
        vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#bb9af7" })
        vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#7dcfff", bold = true })
        vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = "#bb9af7" })
        vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = "#c0caf5" })
      end
      hl()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = hl })
    end,
    opts = {
      dashboard = {
        enabled = true,
        preset = {
          header = [[
 ███╗   ██╗██╗   ██╗██╗███╗   ███╗
 ████╗  ██║██║   ██║██║████╗ ████║
 ██╔██╗ ██║██║   ██║██║██╔████╔██║
 ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
 ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝

        λ  C  &  Python]],
          keys = {
            { icon = ic(0xf15b), key = "n", desc = "Novo projeto",
              action = function() vim.api.nvim_feedkeys(vim.keycode("<leader>nn"), "m", false) end },
            { icon = ic(0xf07b), key = "p", desc = "Abrir meus projetos",
              action = function()
                vim.cmd("cd " .. vim.fn.fnameescape(vim.fn.expand("~/projetos")))
                Snacks.dashboard.pick("files")
              end },
            { icon = ic(0xf002), key = "f", desc = "Buscar arquivo",
              action = ":lua Snacks.dashboard.pick('files')" },
            { icon = ic(0xf1da), key = "r", desc = "Arquivos recentes",
              action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = ic(0xf002), key = "g", desc = "Buscar texto",
              action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = ic(0xf013), key = "c", desc = "Configuração do nvim",
              action = function()
                vim.cmd("cd " .. vim.fn.fnameescape(vim.fn.stdpath("config")))
                Snacks.dashboard.pick("files")
              end },
            { icon = ic(0xf0e7), key = "l", desc = "Plugins (Lazy)", action = ":Lazy" },
            { icon = ic(0xf426), key = "x", desc = "Extras do LazyVim", action = ":LazyExtras" },
            { icon = ic(0xf425), key = "q", desc = "Sair", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 2 },
          { section = "startup" },
        },
      },
    },
  },
}
