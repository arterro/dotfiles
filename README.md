# Dotfiles

Contains configurations / settings for personalizing Linux. 

`_deskmod` will serve as the site for storing cofigurations for different desktop environments (DE) and compositors for customizing look and feel. It will contain a text file for required packages, please note that this is catered to Arch Linux, it can help to see required packages needed on your system but the packages itself are set to how they are named in AUR and the official Arch repository.

## Installation

Clone this repository

```sh
git clone --recurse-submodules -j8 https://gitlab.com/arturodelgado/dotfiles.git ~/.dotfiles
```

Change into the cloned directory

```sh
cd ~/.dotfiles
```

Run the provisioning script

```sh
./provision 
```
