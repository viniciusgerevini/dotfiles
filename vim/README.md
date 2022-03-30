# VIM Config

Honestly, I haven't been giving my vim config as much love as I'm using Neovim in my day-to-day.

Nvim has better defaults and the newest versions have extremely good features (LSP). My current Neovim configuration performs way better than this for programming.

However, I still use vim in my Raspberry PI and servers.

## External dependencies

- curl (only required for installing vim-plug. If you install it manually, you don't need curl)
- [Nerdfont](https://www.nerdfonts.com) patched font (for icons).

## Notes

- All configuration is in one file (`.vimrc`)
- vim-plug is automatically installed on the first run. After installation is complete, you will have to restart nvim.
- Uses base16 colorscheme. The current config adapts to whatever colorscheme ZSH is using. Check the ZSH config for more info about base16 themes.
- As it's using base16 colorschemes, this config does not support any plugin that requires `termguicolors`. You can enable it, but you will have to change the colorscheme.
