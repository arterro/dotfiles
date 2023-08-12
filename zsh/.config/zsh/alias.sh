alias work='cd $WORK'
alias notes='cd $NOTES'
alias dotfiles='cd $DOTFILES'

alias zshconfig='${EDITOR} $HOME/.zshrc'
alias envconfig='${EDITOR} $HOME/.config/zsh/env.sh'
alias aliasconfig='${EDITOR} $HOME/.config/zsh/alias.sh'
alias helperconfig='${EDITOR} $HOME/.config/zsh/helper.sh'

alias gnomedump="echo 'Saving Gnome configuration to $DOTFILES/_deskmod/gnome/gnome-config'; dconf dump / >! $DOTFILES/_deskmod/gnome/gnome-config"

alias tmain='~/.tmux/tmux-bootstrap.sh arterro'

alias ssh="kitty +kitten ssh"

alias k=kubectl
compdef __start_kubectl k
