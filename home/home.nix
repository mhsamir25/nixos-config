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

#zsh
programs.zsh = {
  enable = true;

  shellAliases = {
    ll = "eza -lah";
    la = "eza -a";
    cat = "bat";
    ".." = "cd ..";
    "..." = "cd ../..";
    gs = "git status";
    ga = "git add";
    gc = "git commit";
    gp = "git push";
    rebuild = "sudo nixos-rebuild switch --flake ~/nixos#nixos";
    update = "cd ~/nixos && nix flake update && sudo nixos-rebuild switch --flake .#nixos";
  };

  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;

  oh-my-zsh = {
    enable = true;
    plugins = [
      "git"
      "sudo"
      "command-not-found"
    ];
  };

  plugins = [
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
  ];
  initExtra = ''
  source ~/.p10k.zsh
'';
};

  # Git configuration
  programs.git = {
    enable = true;

    # CHANGE THESE TWO
    settings.user.name = "Mahmudul Hossain Samir";
    settings.user.email = "mahmudul1@iut-dhaka.edu";
  };

  programs.home-manager.enable = true;

  #powerlevel10k
  home.file.".p10k.zsh".source = ./p10k.zsh;
}
