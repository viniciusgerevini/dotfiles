# Neovim Config

## External dependencies

- curl (only required for installing vim-plug. If you install it manually, you don't need curl)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (used by Telescope)
- [Nerdfont](https://www.nerdfonts.com) patched font (for icons).

## Notes

- nvim `>= 0.6`
- All configuration is in one file (`init.vim`)
- vim-plug is automatically installed on the first run. After installation is complete, you will have to restart nvim.
- Uses base16 colorscheme. The current config adapts to whatever colorscheme ZSH is using. Check the ZSH config for more info about base16 themes.
- As it's using base16 colorschemes, this config does not support any plugin that requires `termguicolors`. You can enable it, but you will have to change the colorscheme.
