{ config, lib, ... }:
let
  inherit (config.lib.stylix.colors) base00 base01 base02 base03 base04 base05 base06 base08;
in
{
  services.mako = {
    enable = true;
    borderColor = lib.mkForce "#${base05}";
    backgroundColor = lib.mkForce "#${base01}";
    borderRadius= 10;
    defaultTimeout = 5000;
  };
}
