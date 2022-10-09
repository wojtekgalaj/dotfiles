# My dotfiles

This repository contains most of my dotfiles. At least the ones I care about enough to want to persist as I inevitably change computers.

## Note to self

Now that you've forgotten how this is supposed to work, let me remind you.

This is managed with GNU stow. You will need to install it on the system you are on now first.

Once you have stow installed, clone this repository and from it's root directory issue the following command:

```sh
stow --dotfiles *
```

This `--dotfiles` flag will preprocess everything and replace "dot-" with an actual .

Since most of the files here are in fact dot files, without this preprocessing we'd have a folder full of invisible files.

## Warning

Currently if you try to use this `--dotfile` flag on a folder containing a `dot-` folder, stow will break. There is a ticket open on github for it here: https://github.com/aspiers/stow/issues/33

So right now, when you `cd` into a folder that looks empty, make sure you're showing hidden files too.




