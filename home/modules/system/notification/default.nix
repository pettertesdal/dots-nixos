{ config, lib, ... }:
let
  inherit (config.lib.stylix.colors) base00 base01 base02 base03 base04 base05 base06 base08;
in
{
  services.mako = {
    enable = true;
    borderColor = lib.mkForce "#${base05}";
    defaultTimeout = 30000;
  };
}
