#*****************
# Powerlevel10k Initialization
#*****************

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Install Powerlevel10k
if [[ ! -d $HOME/powerlevel10k ]]; then
    echo "Powerlevel10k not found, installing before proceeding with ZSH run commands..."
	sleep 0.500
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k
	
    if [[ $(grep -w powerlevel10k.zsh-theme ~/.zshrc | wc -l) -lt 3 ]]; then
        echo "\nsource ${HOME}/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
    fi
fi

#*****************
# GLOBAL SETTINGS
#*****************

unsetopt CORRECT                    # Disable autocorrect guesses. Happens when typing a wrong
                                    # command that may look like an existing one.

expand-or-complete-with-dots() {    # This bunch of code displays red dots when autocompleting
    echo -n "\e[31m......\e[0m"     # a command with the tab key, "Oh-my-zsh"-style.
    zle expand-or-complete
    zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

#*****************
# SOURCE CONFIGURATIONS
#*****************

#***
# Prezto - zsh framework
#***
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#*** 
# zsh - Custom paths/envs, helper functions and aliases
#***
if [[ -d $HOME/.config/zsh ]]; then
    for config in $HOME/.config/zsh/*; do
        source $config
    done
fi

#*** 
# Powerlevel10k - Makes it look pretty
#***
[[ ! -f $HOME/.p10k.zsh ]] || source ~/.p10k.zsh

#***************
# To Oraganize
#***************

[ -e "$HOME/.dir_colors" ] && DIR_COLORS="$HOME/.dir_colors"
eval "`dircolors -b $DIR_COLORS`"

if [[ $- != *i* ]] ; then
	return
fi

# Create npm-global Directory
if [[ ! -d $HOME/.npm-global ]]; then
	mkdir $HOME/.npm-global
	npm config set prefix $HOME/.npm-global
fi

# Setup NVM for autoload
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
source /usr/share/nvm/init-nvm.sh

export GOPATH=$HOME/go

export PATH=$HOME/.local/bin:$PATH

eval "$(direnv hook zsh)"

export PATH=$PATH:~/bin:~/.npm-global/bin

source ${HOME}/powerlevel10k/powerlevel10k.zsh-theme
