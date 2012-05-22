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

    % git clone git://github.com/jmaurice/profiles.git ~/.profiles
    % cd ~/.profiles
    % git submodule init
    % git submodule update
	% cd ~/
	% ln -s .profiles/.zshrc
	% ln -s .profiles/.vimrc
	% ln -s .profiles/.vim
	% cp .profiles/site-functions/* /usr/share/zsh/site-functions/
	### if not root then uncomment adding .profiles/site-functions to $fpath in .zshrc

	make other symlinks etc. as needed
