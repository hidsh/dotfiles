# My dotfiles

This repo uses [dotbot](https://github.com/anishathalye/dotbot).

This branch is for:
	- Machine: Macbook Pro late 2013
	- OS: Pop!\_OS 22.04 (x86\_64)

# Prerquisites

- git
- wezterm
- neovim (based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim))
- zsh
	- sheldon
	- fzf
	- ripgrep
	- eza
	- fd

# Folder structure

`dotfiles/d` has main contents like that.

```
~/dotfiles 󰜴 \tree -a -I .git -I dotbot d                                                     master
d
├── nvim
│   └── init.lua
└── zsh
    ├── sheldon
    │   ├── defer.zsh
    │   ├── plugins.toml
    │   └── sync.zsh
    ├── wezterm.sh
    └── zshrc
```

# Usage

## On a New Machines

```
git clone git@github.com:hidsh/dotfiles.git --recursive
cd dotfiles && ./install
```

## Update

```
git fetch
git pull && ./install
```

