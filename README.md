# VIMFILES

Yes, this is absolutely a me too repo. This configuration is used
by me on a daily basis in my favorite Vim version: MacVim.

## To get started

1. From your terminal:

    cd ~
    git clone git://github.com/bulters/vimfiles.git
    ln -s vimfiles ~/.vim
    ln -s vimfiles/vimrc ~/.vimrc

2. From vim

    :e ~/.vimrc
    :BundleInstall

3. You're al... no not quite yet.

*Command-T* will require compilation to do some textmate like quick go-to-file magic.
So to compile the m***:

    cd ~/vimfiles/bundle/command-t && rake make && cd

4. You're all set!

## What in there?

In no particular order:

* Vundle: To install plugins/filetypes/color themes with great ease.
* Solarized: The amazin color theme; I prefer the light version.
* Fugitive/Git: Git VC right from Vim.
* VimClojure: Yeah, I should be using Emacs for this; but can't get my head/fingers around the keybindings.

