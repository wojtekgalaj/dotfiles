# Bare git repository

This home directory uses a bare git repository to be able to add any file from the home folder to a git repository without the need of simlinking them afterwards.

I saw this on distrotube's channel. (Here's)[https://www.youtube.com/watch?v=tBoLDpTWVOM&t=909s] the video

Here's the readme found under the video, in case that should ever go away :)

## Video description. By distrotube

I've been looking for a better way to manage my dotfiles.  My old method involved moving all of my dotfiles into their own directory and then symlinking each one of them back into the directory structure.  What a headache!

Using git bare repositories, there is no more moving files into an initialized git repository and then creating symlinks.  Now, I just add, commit and then push.  Done.

Want to make your own git bare repository?  First, make a directory for your new git bare repository (I created one called "dotfiles" but you can name it whatever).

Then I entered the following in the terminal:

git init --bare $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' (add this alias to .bashrc)
bash
config config --local status.showUntrackedFiles no

Basic usage example:

config add /path/to/file
config commit -m "A short message"
config push

WHAT'S THE REASON FOR THE GIT BARE REPO?

By using the git bare repo, you can have nested git repos in your home directory and there will not be any issue with keeping things straight.   That is the reason for the git bare repo and having an alias ("config").
