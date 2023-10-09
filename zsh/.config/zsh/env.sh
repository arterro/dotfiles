# shellcheck disable=SC2155

#**********
# ENVIRONMENT
#**********
export SHELL=$(which zsh)
export WORK=$HOME/work
export GPG_TTY=$TTY
export DOTFILES=$HOME/.dotfiles
export NOTES=$HOME/notes
export TERM=xterm-256color

export USER_NAME=$(whoami)

export PAGER='less'
export EDITOR='vim'
export BROWSER='firefox'
export FMANAGER='ranger'
export READER='zathura'
export TERMINAL='kitty'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

export GOPATH=$HOME/go

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export MOZ_DBUS_REMOTE=1
    export MOZ_ENABLE_WAYLAND=1
fi

#**********
# PATHS
#**********

if [[ -z "$TMUX" ]]; then
    path=("$HOME/.local/bin" /usr/local/{bin,sbin} $path)
    path+=("$HOME/.emacs.d/bin" "$HOME/bin" "$HOME/.npm-global/bin")
    path+=("$GOPATH/bin")
    
    if [[ $(uname -s) == "Darwin" ]]; then
        path=("/opt/homebrew/bin" $path)
        
        if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
            path=("$(gem environment gemdir)/bin" "/opt/homebrew/opt/ruby/bin" $path)
        fi
    fi
fi

# Remove duplicates paths
typeset -U path
