Profiles
========

This repository includes configuration files, plugins, and add-on scripts for zsh, vim, and other stuff I use.
This collection is based off niw's repo: https://github.com/niw/profiles

License
=======

These files inside this repository is under MIT License, see MIT-LICENSE.txt.
This repository also contains some third party scripts, files and commands so that I and you can use it easily though, these files are NOT under this license but under each licenses.

Setup
=======

For example, starting with a fresh Ubuntu 16 LTS clean install

```
# update latest stuff
apt-get update
apt-get upgrade

# install vm tools
apt-get install open-vm-tools open-vm-tools-desktop

# install basic stuff
apt-get install zsh vim screen git gcc consolekit roxterm awesome awesome-extra compton feh mutt gnupg2 pcscd scdaemon pinentry-gtk2

# install dotfiles
git clone https://github.com/jmaurice/profiles .profiles
cd .profiles
git submodule update --init --recursive
cd
ln -s .profiles/.gitconfig
ln -s .profiles/.vimrc
ln -s .profiles/.vim
ln -s .profiles/.zshrc
ln -s .profiles/gui/.xsessionrc

# setup zsh
chsh -s `which zsh`
sudo cp .profiles/zsh-git/functions/* /usr/local/share/zsh/site-functions/

# setup gui configurations
cd ~/.config
ln -s ../.profiles/gui/roxterm.sourceforge.net
ln -s ../.profiles/gui/awesome
ln -s ../.profiles/gui/compton.conf

# setup wallpaper
mkdir ~/Pictures/Wallpaper/
cp ~/.profiles/gui/awesome/leet/pengi-background-2560x1600.png ~/Pictures/Wallpaper/

# setup retina display scaling
echo "Xft.dpi: 200.0" > ~/.Xresources
xrdb -merge ~/.Xresources

# change default display manager to gdm3 to fix flickering when changing workspaces
sudo apt-get install gdm3
# cd /etc/X11
# echo /usr/sbin/gdm3 > default-display-manager
reboot
```

