return {
  { "rebelot/kanagawa.nvim" },
  { "rafcamlet/nvim-luapad" },

  {
    "nvim-telescope/telescope.nvim",
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

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
    mappings = {
      n = {
        ["H"] = "<cmd>bufferlinecycleprev<cr>",
        ["L"] = "<cmd>bufferlinecyclenext<cr>",
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
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

  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
    },
  },

  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      mappings = {
        comment_line = [[<a-;>]], -- normal mode
        comment_visual = [[<a-;>]], -- visual mode
      },
      hooks = {
        post = function()
          local mode = vim.api.nvim_get_mode()["mode"]
          if mode == "n" then
            vim.cmd("normal! j") -- (next-line 1) on emacs
          end
        end,
      },
      --]]
    },
  },

  --  { "", },
}
