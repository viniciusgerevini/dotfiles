### ZPLUG
if [ ! -d ~/.zplug ]
then
  echo "installing zplug"
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

source ~/.zplug/init.zsh

#### PLUGINS
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
if [[ -n $(command -v fzf) ]] ; then
  zplug "junegunn/fzf", use:"shell/*.zsh"
fi
####

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to $PATH
zplug load


#### BASE 16
BASE16_SHELL=$HOME/.config/base16-shell/

if [ ! -d $BASE16_SHELL ]
then
  git clone https://github.com/chriskempson/base16-shell.git $BASE16_SHELL
fi

[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

### ZSH OPTIONS

# history
HISTSIZE=50000
SAVEHIST=10000
HISTFILE="$HOME/.history"

# record timestamp of command in HISTFILE
setopt extended_history
# delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_expire_dups_first
# ignore duplicated commands history list
setopt hist_ignore_dups
# ignore commands that start with space
setopt hist_ignore_space
# show command with history expansion to user before running it
setopt hist_verify
# add commands to HISTFILE in order of execution
setopt inc_append_history
# share command history data
setopt share_history

# tab autocompletion
autoload -U compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# prompt
autoload -U promptinit
promptinit
setopt prompt_subst

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "%{$fg[cyan]%}(%b%c%u%{$fg[cyan]%})%F{reset}"
zstyle ':vcs_info:git*' actionformats "%{$fg[cyan]%}(%b%{$fg[red]%}%a{$fg[cyan]%})%F{reset}"

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%{$fg[green]%}*%F{reset}"
zstyle ':vcs_info:*' unstagedstr "%{$fg[red]%}*%F{reset}"


precmd() {
  vcs_info
}

prompt_status="%(?:%{$fg[blue]%}❯:%{$fg[red]%}❯)%F{reset}"
prompt_user_mark="%(!.#)"

PS1='$prompt_status %1~ ${vcs_info_msg_0_} $prompt_user_mark '

### FIXES

# Required for GPG signature
export GPG_TTY=$(tty)

# fixing TMUX bracketed paste issue
if [ ${TMUX} ]; then
  unset zle_bracketed_paste
fi

### USER CONFIGURATION

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.cargo/bin:$PATH"

function load_file_if_exists() {
  if [ -e "$1" ]
  then
    source "$1"
  fi
}

load_file_if_exists ~/.private/scripts.sh
load_file_if_exists ~/.nvm/nvm.sh
