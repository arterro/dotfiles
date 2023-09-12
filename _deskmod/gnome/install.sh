#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd $parent_path

source ../../helpers

gnome_shell_dir="$HOME/.local/share/gnome-shell"
gnome_extensions_dir="$gnome_shell_dir/extensions"

echo -e "\nThe following packages for gnome will be installed:\n"
cat ./gnome_packages.txt
start_spinner "\nPreparing installation of packages... "
sleep 6
stop_spinner

yay -Syu --needed --noconfirm - < gnome_packages.txt

spinner "\nInitializing post installation configurations... "

if [[ ! -d "$gnome_extensions_dir" ]]; then
    echo "Creating extensions directory: $gnome_extensions_dir"
    mkdir -p "$gnome_shell_dir"
    ln -s "$(pwd)/extensions" "$gnome_extensions_dir"
fi

echo -e "Establishing wallpaper...\n"
cp ./wallpaper.png $HOME
gsettings set org.gnome.desktop.background picture-uri file:///$HOME/wallpaper.png
gsettings set org.gnome.desktop.background picture-uri-dark file:///$HOME/wallpaper.png

echo -e "Establishing gnome configurations...\n"
dconf load / < gnome-config

echo -e "Removing special keybinds...\n"
gsettings set org.gnome.settings-daemon.plugins.media-keys rotate-video-lock-static "[]"

for f in extensions/*; do
    if [[ -d "$f" ]]; then
        extension=$(basename "$f")
        spinner "Enabling extension $extension... "
        gnome-extensions enable "$extension"
    fi
done

spinner "\nEnabling and starting gdm service..."

sudo systemctl enable gdm.service
sudo systemctl start gdm.service
