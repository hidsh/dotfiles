return {
  { "rebelot/kanagawa.nvim" },
  { "rafcamlet/nvim-luapad" },
  { "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
    },
  },
  { "akinsho/bufferline.nvim",
    opts = function(_, opts)
      opts.options.show_buffer_close_icons = false
      opts.options.show_close_icon = false
    end,
  },
  { "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_b = {},
        lualine_x = { "filetype" },
        lualine_y = { "branch", "diff" },
        lualine_z = { "location" },
      },
    },
  },
}
