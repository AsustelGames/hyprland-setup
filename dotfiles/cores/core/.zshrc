zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit


# Socket management more info at ...
export KITTY_SOCKET_DIR="$XDG_RUNTIME_DIR/kitty-sockets"
export NVIM_SOCKET_DIR="$XDG_RUNTIME_DIR/nvim-sockets"

mkdir -p $KITTY_SOCKET_DIR
mkdir -p $NVIM_SOCKET_DIR

chmod 700 $KITTY_SOCKET_DIR
chmod 700 $NVIM_SOCKET_DIR

export NVIM_LISTEN_ADDRESS="$NVIM_SOCKET_DIR/$(uuidgen).sock"


# Plugins
export ZSH="$HOME/.zsh"
source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/fzf-tab/fzf-tab.zsh


# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt INC_APPEND_HISTORY
setopt HIST_FCNTL_LOCK
unsetopt SHARE_HISTORY


# Keybindings
bindkey -e
bindkey '^I' autosuggest-accept # Tab
bindkey '^[[Z' fzf-tab-complete # Shift+Tab

function clear-line() { BUFFER="" CURSOR=0 }
zle -N clear-line
bindkey '^@' clear-line # Shift + Space


# Prompt
PROMPT='(%B%F{magenta}%D{%I:%M %p}%f%b)->%F{green}(%U%B%~%u%b)
 %f> '


# Aliases
alias lsn='\ls'
alias ls='eza --icons=always --color=always'
alias ll='eza --icons=always --color=always -l'
alias lsr='eza --icons=always --color=always -R'
alias lst='eza --icons=always --color=always -T'
alias lsa='eza --icons=always --color=always -a'

alias cp='rsync -ah --info=progress2'

alias a='alias'

alias s='sudo'


# Editing
export EDITOR="nvim"
export SUDO_EDITOR="nvim"

alias e='$EDITOR'
alias se='sudoedit'


# Cd
alias ..='cd ..'
alias ...='cd ../..'


# Programs
alias nv='nvim'
alias vs='code'
alias na='nano'

alias y='yazi'
alias lg='lazygit'


# Creating & Removing
alias srm='sudo rm'
alias rr='rm -r'
alias srr='sudo rm -r'

alias mkd='mkdir'
alias skmd='sudo mkdir'

alias t='touch'
alias st='sudo touch'


# Fun Stuff
alias cm='cmatrix'
alias pi='pipes-rs'
alias ca='cava'
alias ff='fastfetch --config ~/.config/fastfetch/fastfetch.jsonc --logo ~/.config/fastfetch/logo.txt'

# NixOS
alias nxre-auto='bash $HOME/.config/scripts/nixos-rebuild.sh --auto'
alias nxre-laptop='sudo nixos-rebuild switch --flake /etc/nixos#laptop --impure && hyprctl reload'
alias nxre-desktop='sudo nixos-rebuild switch --flake /etc/nixos#desktop --impure && hyprctl reload'

alias nxsh='nix-shell /etc/nixos/shell.nix'

alias nxls-gens='sudo nixos-rebuild list-generations'
alias nxrm-gens='sudo nix-collect-garbage -d'

alias nxup='sudo nix flake update --flake /etc/nixos --impure'

# Hyprland
alias hlre='hyprctl reload'
alias hlmo='hyprctl monitors'
alias hlla='hyprctl layers'

# Custom
alias menu='bash $HOME/.config/scripts/menu.sh'
alias menuCore='bash /etc/nixos/dotfiles/cores/core/.config/scripts/menu.sh'
