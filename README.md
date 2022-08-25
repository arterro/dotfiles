# Dotfiles

Contains configurations / settings for personalizing Linux. 

`_deskmod` will serve as the site for storing cofigurations for different desktop environments (DE) and compositors for customizing look and feel. It will contain a text file for required packages, please note that this is catered to Arch Linux, it can help to see required packages needed on your system but the packages itself are set to how they are named in AUR and the official Arch repository.

## Prerequisite

The configurations are symlinked to their required locations via the use of [stow](https://www.gnu.org/software/stow/).

Packages required are spread out between the Arch offical repository and AUR, so having an AUR helper installed would be beneficial, I personally utilize [yay](https://github.com/Jguer/yay).

## Installation

Clone this repository

```sh
git clone --recurse-submodules -j8 https://github.com/arterro/dotfiles.git ~/.dotfiles
```

Change into the cloned directory
```sh
cd ~/.dotfiles
```

Symlink the top-level configurations
```sh
stow -R *
```

With this the application configurations are in place and can now move on to a desired look and feel within `_deskmod`.

## Look and Feel

Find a look that appeals to you and run the `stow` command against the directory that contains the theme you want.

As an example, we will use `sway`

From the root of `~/.dotfiles`
```sh
stow -R -d ./_deskmod -S sway -t $HOME
```

Install the required packages
```sh
yay -Syu --needed --noconfirm - < ~/packages.txt
```

Log out and log back in and everything should be up and running as expected.
