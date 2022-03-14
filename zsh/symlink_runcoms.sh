#!/bin/bash

rc_ignore="README.md|zshrc|zpreztorc|zprofile" 

shopt -q extglob; extglob_set=$?
((extglob_set)) && shopt -s extglob

for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/!($rc_ignore); do
    ln -s $rcfile "${ZDOTDIR:-$HOME}/.${rcfile##*/}"
done

((extglob_set)) && shopt -u extglob
