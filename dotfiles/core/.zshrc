zstyle :compinstall filename '/home/asustel/.zshrc'
autoload -Uz compinit
compinit


plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt INC_APPEND_HISTORY
setopt HIST_FCNTL_LOCK
unsetopt SHARE_HISTORY

bindkey -e
bindkey '^I' autosuggest-accept # Tab

PROMPT='(%B%F{magenta}%D{%I:%M %p}%f%b)->%F{green}(%U%B%~%u%b)
 %f> '

alias ls='eza --icons=always --color=always'
alias lsa='eza --icons=always --color=always -a'

alias a='alias'

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
alias mi='micro'
alias vs='code'
alias na='nano'

alias y='yazi'

alias mp='mpv'
alias p='mpv'

# Creating
alias md='mkdir'
alias smd='sudo mkdir'

alias t='touch'
alias st='sudo touch'



# NixOS
alias nxre-laptop='sudo nixos-rebuild switch --flake /etc/nixos#laptop --impure && hyprctl reload'
alias nxre-desktop='sudo nixos-rebuild switch --flake /etc/nixos#desktop --impure && hyprctl reload'

alias nxsh='nix-shell /etc/nixos/shell.nix'

alias nxls-gens='sudo nixos-rebuild list-generations'
alias nxrm-gens='sudo nix-collect-garbage -d'

alias nxup='sudo nix flake update --flake /etc/nixos --impure'




