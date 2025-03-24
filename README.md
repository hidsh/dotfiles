# My dotfiles

![screenshot](https://pbs.twimg.com/media/GmkzsigaEAIEbfA?format=jpg&name=4096x4096)

This repo is for:
- PC: AskHand Mini PC (Ryzen 5500U 16GB/1TB+256GB) ~Macbook Pro late 2013~
- OS: Arch Linux ~Pop!\_OS 22.04 (x86\_64)~
- DE/WM: Hyprland

# Prerquisites

This repo uses [dotbot](https://github.com/anishathalye/dotbot).
But no need to install it because it is included as a submodule.

Additional requiremens to be installed are following:
- [archinstall](https://wiki.archlinux.org/title/Archinstall) + hyprland + [ML4W hyprdots](https://github.com/mylinuxforwork/dotfiles)<br> (YouTube: [Install ARCH Linux with HYPRLAND profile plus the ML4W Dotfiles 2.9.7.4. THE full installation guide](https://youtu.be/sVFnd5LAYAc?si=qkykX7vqlmMmCfpX&t=302))
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

Folder `d` has main contents as following:
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
git status	# check if not dirty 
git pull
./install
```

