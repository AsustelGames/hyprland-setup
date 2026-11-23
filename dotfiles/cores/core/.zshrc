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


# Variables
nixosDir="/etc/nixos"
scriptDir="${nixosDir}/dotfiles/cores/core/.config/scripts"
homeConfigDir="$HOME/.config"
homeScriptDir="${homeConfigDir}/scripts"

export EDITOR="nvim"
export SUDO_EDITOR="nvim"

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
alias e='$EDITOR'
alias se='sudoedit'
alias ae='bash ${scriptDir}/cli-utils/autoedit.sh'

# Programs
alias nv='nvim'
alias na='nano'

alias y='yazi'
alias lg='lazygit'
alias slg='sudo lazygit'
alias sc='shellcheck'

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
alias ff='fastfetch --config ${homeConfigDir}/fastfetch/fastfetch.jsonc --logo ${homeConfigDir}/fastfetch/logo.txt'

# NixOS
alias nxre='bash ${scriptDir}/cli-utils/nixos-system-rebuild.sh'
alias nxup='bash ${scriptDir}/cli-utils/nixos-system-update.sh'

alias nxls-gens='sudo nixos-rebuild list-generations'
alias nxrm-gens='sudo nix-collect-garbage -d'

# Hyprland
alias hlre='hyprctl reload'
alias hlmo='hyprctl monitors'
alias hlla='hyprctl layers'
alias hlcl='hyprctl clients'
alias hlde='hyprctl devices'

# Custom
alias menu='bash ${homeScriptDir}/menu.sh'
alias menu-core='bash ${scriptDir}/menu.sh'

alias pkgs='sudoedit ${nixosDir}/nixos/default/packages/packages.nix'
alias pkgconf='sudoedit ${nixosDir}/nixos/default/packages/package-config.nix'
alias todo='sudoedit ${nixosDir}/todo.txt'
alias flake='sudoedit ${nixosDir}/flake.nix'

alias nixos='cd "${nixosDir}"'
alias scripts='cd "${homeScriptDir}"'
alias scripts-core='"${scriptDir}"'
