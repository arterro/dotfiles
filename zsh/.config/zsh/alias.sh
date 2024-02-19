alias work='cd $WORK'
alias projects='cd $WORK/projects'
alias notes='cd $NOTES'
alias dotfiles='cd $DOTFILES'

alias zshconfig='${EDITOR} $HOME/.zshrc'
alias envconfig='${EDITOR} $HOME/.config/zsh/env.sh'
alias aliasconfig='${EDITOR} $HOME/.config/zsh/alias.sh'
alias helperconfig='${EDITOR} $HOME/.config/zsh/helper.sh'

alias gnomedump="echo 'Saving Gnome configuration to $DOTFILES/_deskmod/gnome/gnome-config'; dconf dump / >! $DOTFILES/_deskmod/gnome/gnome-config"
alias gnomeload="echo 'Loading Gnome configuration from $DOTFILES/_deskmod/gnome/gnome-config'; dconf load / < $DOTFILES/_deskmod/gnome/gnome-config"

alias tmain='~/.tmux/tmux-bootstrap.sh arterro'

alias gmpv="gnome-session-inhibit mpv ${1}"

alias k=kubectl
alias kns="k config set-context --current --namespace ${1}"
compdef __start_kubectl k
