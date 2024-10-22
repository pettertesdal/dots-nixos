{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./home/modules/system/stylix
      ./vm.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "penguin-B"; # Define your hostname.

  # Music

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Docker
  virtualisation.docker.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "no";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "no";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tesdap = {
    isNormalUser = true;
    description = "Petter";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd"];
    packages = with pkgs; [];
  };

  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Setting up hyprland
  programs.hyprland.enable = true;


  security = {
    pam.services.hyprlock = {};
    polkit.enable = true;
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.tesdap.shell = pkgs.zsh;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    waybar
    eww

    (texlive.combine { inherit (texlive) scheme-full tcolorbox ifmtarg framed paralist titlesec enumitem; })
    # Notification
    libnotify
    git
    ncmpcpp
    mpc-cli
    kitty
    rofi-wayland
    firefox
    swww
    openssh
    wget
    wl-clipboard
    curl

    devenv
    dbeaver-bin
    beekeeper-studio
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MPD_HOST = "/run/user/1000/mpd/socket";
  };
  environment.variables.EDITOR = "nvim";

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];


  # SSH
  services.openssh = {
    enable = true;
  };

  security.rtkit.enable = true;
    services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Automatic garbage collect
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      trusted-users = root tesdap
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
