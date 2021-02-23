{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "wojtek";
  home.homeDirectory = "/Users/wojtek";

  home.packages = with pkgs; [
  ];

  home.stateVersion = "21.03";

  programs.bat.enable = true;
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      coc-nvim
      typescript-vim
      vim-jsx-typescript
      vim-javascript
    ];
  };
  
}
