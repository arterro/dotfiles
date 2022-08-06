#**********
# ENVIRONMENT
#**********

export WORK=$HOME/work
export GPG_TTY=$(tty)
export DOTFILES=$HOME/.dotfiles
export NOTES=$HOME/notes

export USER_NAME=$(whoami)

export PAGER='less'
export EDITOR='vim'
export BROWSER='firefox'
export FMANAGER='ranger'
export READER='zathura'
export TERMINAL='alacritty'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export GOPATH=$HOME/go

if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi

#**********
# PATHS
#**********

if [[ -z $TMUX ]]; then
    path=($HOME/.local/bin $path)
    path=($HOME/.emacs.d/bin $path)
    path+=(~/bin ~/.npm-global/bin)
    path+=($GOPATH/bin)
    
    if [[ $(uname -s) == "Darwin" ]]; then
        path=(/opt/homebrew/bin $path)
    fi
fi
