{ config, pkgs, inputs, ... }:

{
  imports = [
    ./home/modules/system/wm/hyprland.nix
    ./home/modules/system/fonts
    ./home/modules/system/waybar
    ./home/modules/system/utils
    ./home/modules/system/fileManager
    ./home/modules/tui/nixvim
    ./home/modules/tui/shell
    ./home/modules/tui/notes
    ./home/modules/gui
    ./home/modules/scripts/notetaking
    ./home/modules/scripts/tmux
  ];
  home.username = "tesdap";
  home.homeDirectory = "/home/tesdap";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';


  programs.nixvim.enable = true;


  programs.bash.enable = true;
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    neofetch

    # Textdocuments
    (texlive.combine { inherit (texlive) scheme-full xifthen ifmtarg framed paralist titlesec enumitem; })
  
    zathura # Pdf viewer

    # archives

    # utils

    # networking tools
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    httpie

    inkscape
    # misc
    tree

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    glow # markdown previewer in terminal

    # system tools
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Petter Tesdal";
    userEmail = "584903@stud.hvl.no.com";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };


  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  stylix.targets.alacritty.enable = false;
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      font = {
        normal.family = "FantasqueSansM Nerd Font";
        size = 12;
        bold = { style = "Bold"; };
      };
      window.padding = {
        x = 2;
        y = 2;
      };
      shell.program = "${pkgs.zsh}/bin/zsh"; 
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
