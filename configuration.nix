{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./home/modules/system/stylix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "penguin-B"; # Define your hostname.

  # Music
  services.mpd = {
    enable = true;
    extraConfig = ''
      audio_output {
              type "pipewire"
              name "PipeWire Sound Server"
      }'';
    startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  };

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
    extraGroups = [ "networkmanager" "wheel" ];
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
    dunst
    libnotify
    git
    mpd
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
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
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
