{ pkgs, ... }: {
  imports = [
    ./jetbrains.nix
    ./zed.nix
  ];
  home.packages = with pkgs; [
  ];
}

