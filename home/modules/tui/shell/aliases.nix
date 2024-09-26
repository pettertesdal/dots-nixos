{
  home.shellAliases = {
    sysupdate = "sudo nixos-rebuild switch --flake ~/.dots/";
    systest = "sudo nixos-rebuild test --flake ~/.dots/";
  };
}
