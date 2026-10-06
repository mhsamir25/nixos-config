{ config, pkgs, ... }:

{
  home.username = "ecstatic_sam25";
  home.homeDirectory = "/home/ecstatic_sam25";

  home.stateVersion = "26.05";

  # User-level packages
  home.packages = with pkgs; [
    eza
    bat
    fzf
  ];

  # Zsh
  programs.zsh = {
    enable = true;

    shellAliases = {
      ll = "eza -lah";
      cat = "bat";
      ".." = "cd ..";
    };
  };

  # Git configuration
  programs.git = {
    enable = true;

    # CHANGE THESE TWO
    userName = "Mahmudul Hossain Samir";
    userEmail = "mahmudul1@iut-dhaka.edu";
  };

  programs.home-manager.enable = true;
}
