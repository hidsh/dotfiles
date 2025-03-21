# My dotfiles

This repo is for:
- Machine: AskHand Mini PC (Ryzen 5500U 16GB/1TB+256GB) ~Macbook Pro late 2013~
- OS: Arch Linux ~Pop!\_OS 22.04 (x86\_64)~
- DE/WM: Hyprland

# Prerquisites

This repo uses [dotbot](https://github.com/anishathalye/dotbot).

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

Folder `d` has main contents as follows:
```
~/dotfiles $ \tree -Fa -I .git -I dotbot d
d/
├── bash/
│   └── bashrc
├── nvim/
│   ├── init.lua
│   └── my-add.lua
├── vim/
│   └── vimrc
├── wezterm.lua
└── zsh/
    ├── sheldon/
    │   ├── defer.zsh
    │   ├── plugins.toml
    │   └── sync.zsh
    └── zshrc
```

# Usage

## Install to new machines

```
cd ~
git clone git@github.com:hidsh/dotfiles.git --recursive
cd dotfiles && ./install
```

## Update

```
cd ~/dotfiles
git status	# check not dirty 
git pull
./install
```

