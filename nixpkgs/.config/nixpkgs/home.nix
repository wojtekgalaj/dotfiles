{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "wojtek";
  home.homeDirectory = "/Users/wojtek";

  home.packages = with pkgs; [
    gitAndTools.diff-so-fancy
    ranger
    rename
    fzf
    lf
    ag
    htop
    starship
    ripgrep
    direnv
    tree
    cmake
    fontconfig
    emacs-all-the-icons-fonts
    iosevka
    amfora
    ripgrep
    coreutils
    yarn
    pass
    cheat
    tldr
    cocoapods
    stow
    mkcert
    graphviz
    pandoc
    sqlite
    gh
    bottom
  ];

  home.stateVersion = "21.03";

  programs.bat.enable = true;
}
