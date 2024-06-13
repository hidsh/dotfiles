-- wezterm configuration

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- options
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.92
config.window_close_confirmation = 'AlwaysPrompt'

-- For example, changing the color scheme:
-- config.color_scheme = 'Catppuccin Mocha'
config.color_scheme = 'Catppuccin Frappe'

wezterm.on('toggle-colorscheme', function(window, pane)
  local alter_name = 'base16'
  local overrides = window:get_config_overrides() or {}
  if not overrides.color_scheme then
    overrides.color_scheme = alter_name
  else
    overrides.color_scheme = nil
  end
  window:set_config_overrides(overrides)
end)

-- font
config.font = wezterm.font('Cica', {weight='Regular', stretch='Normal', style='Normal'})
config.font_size = 13

-- https://zenn.dev/paiza/articles/9ca689a0365b05
font = wezterm.font_with_fallback({
  { family = "Cica" },
  { family = "Cica", assume_emoji_presentation = true },
})

-- key bindings
local act = wezterm.action
config.keys = {
  { mods = 'META', key = 'q',action = wezterm.action.EmitEvent 'toggle-colorscheme' },
  { mods = 'META', key = 'n', action = act.SpawnWindow },                                       -- new window
  { mods = 'META', key = 't', action = act.SpawnTab 'CurrentPaneDomain' },                      -- new tab
  { mods = 'CTRL', key = 'w', action = act.CloseCurrentTab {confirm = true} },                  -- close tab
  { mods = 'META', key = 'u', action = act.ActivateTabRelative(-1) },                           -- next tab
  { mods = 'META', key = 'i', action = act.ActivateTabRelative(1) },                            -- previous tab
  { mods = 'CTRL', key = 'o', action = act.ActivatePaneDirection 'Next' },						-- next pane
  { mods = 'SHIFT|CTRL', key = 'o', action = act.ActivatePaneDirection 'Prev' },			    -- previous pane
  { mods = 'CTRL', key = '0', action = act.CloseCurrentPane {confirm = false} },				-- close current pane
  { mods = 'CTRL', key = '2', action = act.SplitVertical {domain = 'CurrentPaneDomain'} },      -- split pane
  { mods = 'CTRL', key = '3', action = act.SplitHorizontal {domain = 'CurrentPaneDomain'} },    -- split pane
  { mods = 'SHIFT|CTRL', key = 'j', action = act.ScrollByLine(1), },                            -- scroll down
  { mods = 'SHIFT|CTRL', key = 'k', action = act.ScrollByLine(-1) },                            -- scroll up
  { mods = 'META', key = 'c', action = act.CopyTo 'Clipboard' },                                -- copy
  { mods = 'META', key = 'v', action = act.PasteFrom 'Clipboard' },                             -- paste
  { mods = 'META', key = 'h', action = act.SendKey { mods = 'SHIFT|CTRL', key = 'w'} },         -- zsh:backward-kill-word
  { mods = 'META', key = 'f', action = act.SendKey { mods = 'META', key = 'f'} },               -- zsh:emacs-forward-word
--  { mods = 'CTRL', key = 'j', action = wezterm.action.Nop },                                    -- for cursor moving
  { mods = 'CTRL', key = 'l', action = wezterm.action.Nop },                                    -- for cursor moving
  { mods = 'CTRL', key = 'v', action = wezterm.action.Nop },                                    -- for paste
  {key="l", mods="SHIFT|CTRL", action="ShowDebugOverlay"},                                      -- lua repl

  --    { mods = '', key = '', action = act. '' },                              --
}

config.mouse_bindings = {
  -- shift-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'SHIFT',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}


-- and finally, return the configuration to wezterm
return config
