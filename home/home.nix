{ config, pkgs, ... }:

{
  home.username = "ecstatic_sam25";
  home.homeDirectory = "/home/ecstatic_sam25";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
  ];

  programs.home-manager.enable = true;
}

