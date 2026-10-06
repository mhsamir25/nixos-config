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
    # Waybar dependencies
    maple-mono.NF
    pamixer
    pavucontrol
    rofi
    swaynotificationcenter
    btop
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

  #oh-my-zsh = {
   # enable = true;
    #plugins = [
     # "git"
      #"sudo"
      #"command-not-found"
    #];
  #};

  plugins = [
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
  ];
  initContent = ''
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

  #Hyprland
# Enable Hyprland in Home Manager
wayland.windowManager.hyprland = {
  enable = true;
  extraConfig = ''
    input:kb_layout = us
    input:touchpad:tap-to-click = true
    input:touchpad:natural_scroll = true

    exec-once = waybar

    bind = SUPER, Return, exec, kitty
    bind = SUPER, M, exit
  '';
};



# Essential Wayland GUI tools
programs.waybar = let
  custom = {
    font = "Maple Mono";
    font_size = "18px";
    font_weight = "bold";
    text_color = "#FBF1C7";
    background_0 = "#1D2021";
    background_1 = "#282828";
    border_color = "#A89984";
    red = "#CC241D";
    green = "#98971A";
    yellow = "#FABD2F";
    blue = "#458588";
    magenta = "#B16286";
    cyan = "#689D6A";
    orange = "#D65D0E";
    orange_bright = "#FE8019";
    opacity = "1";
    indicator_height = "2px";
  };
in {
  enable = true;

  settings.mainBar = with custom; {
    position = "bottom";
    layer = "top";
    height = 28;
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;
    modules-left = [ "custom/launcher" "hyprland/workspaces" "tray" ];
    modules-center = [ "clock" ];
    modules-right = [ "cpu" "memory" "pulseaudio" "network" "battery" "hyprland/language" "custom/notification" "custom/power-menu" ];

    clock = {
      calendar.format.today = "<span color='#98971A'><b>{}</b></span>";
      format = "{:%H:%M}";
      tooltip = true;
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = "{:%d/%m}";
    };
    "hyprland/workspaces" = {
      active-only = false;
      disable-scroll = true;
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = "I"; "2" = "II"; "3" = "III"; "4" = "IV"; "5" = "V";
        "6" = "VI"; "7" = "VII"; "8" = "VIII"; "9" = "IX"; "10" = "X";
      };
      sort-by-number = true;
      persistent-workspaces = {
        "1" = [ ]; "2" = [ ]; "3" = [ ]; "4" = [ ]; "5" = [ ];
      };
    };
    cpu = {
      format = "<span foreground='${green}'> </span> {usage}%";
      format-alt = "<span foreground='${green}'> </span> {avg_frequency} GHz";
      interval = 2;
      on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float_kitty btop'";
    };
    memory = {
      format = "<span foreground='${cyan}'>󰟜 </span>{}%";
      format-alt = "<span foreground='${cyan}'>󰟜 </span>{used} GiB";
      interval = 2;
      on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] kitty --override font_size=14 --title float_kitty btop'";
    };
    network = {
      format-wifi = "<span foreground='${magenta}'> </span> {signalStrength}%";
      format-ethernet = "<span foreground='${magenta}'>󰀂 </span>";
      tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "<span foreground='${magenta}'>󰖪 </span>";
    };
    tray = { icon-size = 20; spacing = 8; };
    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = "<span foreground='${blue}'> </span> {volume}%";
      format-icons.default = [ "<span foreground='${blue}'> </span>" ];
      scroll-step = 2;
      on-click = "pamixer -t";
      on-click-right = "pavucontrol";
    };
    battery = {
      format = "<span foreground='${yellow}'>{icon}</span> {capacity}%";
      format-icons = [ " " " " " " " " " " ];
      format-charging = "<span foreground='${yellow}'> </span>{capacity}%";
      format-full = "<span foreground='${yellow}'> </span>{capacity}%";
      format-warning = "<span foreground='${yellow}'> </span>{capacity}%";
      interval = 5;
      states.warning = 20;
      format-time = "{H}h{M}m";
      tooltip = true;
      tooltip-format = "{time}";
    };
    "hyprland/language" = {
      tooltip = true;
      tooltip-format = "Keyboard layout";
      format = "<span foreground='#FABD2F'> </span> {}";
      format-fr = "FR"; format-en = "US";
      on-click = "hyprctl switchxkblayout at-translated-set-2-keyboard next";
    };
    "custom/launcher" = {
      format = "";
      on-click-right = "rofi -show drun";
      tooltip = true;
      tooltip-format = "Launcher";
    };
    "custom/notification" = {
      tooltip = true;
      tooltip-format = "Notifications";
      format = "{icon}";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>";
        none = "";
        dnd-notification = "<span foreground='red'><sup></sup></span>";
        dnd-none = "";
        inhibited-notification = "<span foreground='red'><sup></sup></span>";
        inhibited-none = "";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
        dnd-inhibited-none = "";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };
    "custom/power-menu" = {
      tooltip = true;
      tooltip-format = "Power menu";
      format = "<span foreground='${red}'> </span>";
    };
  };

  style = with custom; ''
    * {
      border: none;
      border-radius: 0px;
      padding: 0;
      margin: 0;
      font-family: ${font};
      font-weight: ${font_weight};
      opacity: ${opacity};
      font-size: ${font_size};
    }
    window#waybar { background: ${background_1}; border-top: 1px solid ${border_color}; }
    tooltip { background: ${background_1}; border: 1px solid ${border_color}; }
    tooltip label { margin: 5px; color: ${text_color}; }
    #workspaces { padding-left: 15px; }
    #workspaces button { color: ${yellow}; padding-left: 5px; padding-right: 5px; margin-right: 10px; }
    #workspaces button.empty { color: ${text_color}; }
    #workspaces button.active { color: ${orange_bright}; }
    #clock { color: ${text_color}; }
    #tray { margin-left: 10px; color: ${text_color}; }
    #tray menu { background: ${background_1}; border: 1px solid ${border_color}; padding: 8px; }
    #tray menuitem { padding: 1px; }
    #pulseaudio, #network, #cpu, #memory, #disk, #battery, #language, #custom-notification, #custom-power-menu {
      padding-left: 5px; padding-right: 5px; margin-right: 10px; color: ${text_color};
    }
    #pulseaudio, #language, #custom-notification { margin-left: 15px; }
    #custom-power-menu { padding-right: 2px; margin-right: 5px; }
    #custom-launcher { font-size: 20px; color: ${text_color}; font-weight: bold; margin-left: 15px; padding-right: 10px; }
  '';
};
programs.wofi.enable = true;
programs.kitty.enable = true;
}
