-- keybindings
-- misc.
local o = vim.o

o.expandtab = true			-- expand tab input with spaces characters
o.smartindent = true		-- syntax aware indentations for newline inserts
o.tabstop = 4				-- num of space characters per tab
o.shiftwidth = 4			-- spaces per indentation level


require("lazy").setup("plugins", {
	change_detection = {
		enabled = false,
		notify = false,
	},
})

return {
-- plugins
  { --------------------- theme
    'rebelot/kanagawa.nvim',
    config = function()
        vim.cmd.colorscheme "kanagawa"
    end,
  },

  --[[ disabled on goneovim
  { --------------------- 
    "gbprod/yanky.nvim",
    opts = {
    },
  },
  --]]

  { --------------------- 
    'tzachar/highlight-undo.nvim',
    opts = {
      duration = 500,
      undo = {
        hlgroup = 'HighlightUndo',
        mode = 'n',
        lhs = 'u',
        map = 'undo',
        opts = {}
      },
      redo = {
        hlgroup = 'HighlightUndo',
        mode = 'n',
        lhs = '<S-u>',
        map = 'redo',
        opts = {}
      },
      highlight_for_count = true,
    },
  },


  { --------------------- 
    'kqito/vim-easy-replace',
    config = function()
      vim.g.easy_replace_highlight_ctermbg = 'yellow'
      vim.g.easy_replace_highlight_guibg = 'yellow'
    end
  },

  --[[ template for nvim (Lua) plugins
  { --------------------- 
    '',
    opts = {
    }
  },
  
  --]]

  --[[ template for vim (Vim Script) plugins
  { --------------------- 
    '',
    config = function()
      vim.g.xxx = 
      vim.g.yyy = 
    end
  },
  
  --]]

  --[[
  { "EdenEast/nightfox.nvim",
    config = function()
      require('nightfox').setup({
        options = {
          styles = {
            -- comments = "italic",
            -- keywords = "bold",
            -- types = "italic,bold",
          }
        }
      })
    end
  },
  --]]

}
