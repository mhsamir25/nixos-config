{ config, pkgs, inputs, ... }:

{
  home.username = "ecstatic_sam25";
  home.homeDirectory = "/home/ecstatic_sam25";

  home.stateVersion = "26.05";

  # User-level packages
  home.packages = with pkgs; [
    eza
    bat
    fzf
    pamixer
    pavucontrol
    rofi
    swaynotificationcenter
    btop

    # ---- COLORSHELL ----
    inputs.colorshell.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Required dependencies
    hyprpaper
    gobject-introspection
    procps
    socat
    wireplumber
    libglycin
    libglycin-gtk4
    glycin-loaders
    networkmanager
    pipewire
    gjs
    ags
    pywal16
    grim
    slurp

    # Optional but recommended
    uwsm
    cliphist
    hyprsunset
    overskride
    hyprlock
    nerd-fonts.symbols-only   # <-- THE FIX
    hyprpicker
    wf-recorder
  ];
  # zsh
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
      
      # Updated aliases below
      rebuild = "sudo env NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild switch --flake ~/nixos#nixos --impure";
      update = "cd ~/nixos && nix flake update && sudo env NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild switch --flake .#nixos --impure";
    };


    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initContent = ''
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';
  };

  # Git configuration
  programs.git = {
    enable = true;
    settings.user.name = "Mahmudul Hossain Samir";
    settings.user.email = "mahmudul1@iut-dhaka.edu";
  };

  programs.home-manager.enable = true;

  # powerlevel10k
  home.file.".p10k.zsh".source = ./p10k.zsh;

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      input:kb_layout = us
      input:touchpad:tap-to-click = true
      input:touchpad:natural_scroll = true

      # ---- Wallpapers dir for colorshell ----
      # CHANGE THIS PATH to wherever your wallpapers actually live
      env = WALLPAPERS, ~/Pictures/_pictures/wallpapers

      # ---- Startup ----
      # waybar is disabled since colorshell replaces it (bar + notif + CC)
      # exec-once = waybar
      exec-once = colorshell

      bind = SUPER, Return, exec, kitty
      bind = SUPER, M, exit
    '';
  };

programs.wofi.enable = true;
programs.kitty.enable = true;
}
