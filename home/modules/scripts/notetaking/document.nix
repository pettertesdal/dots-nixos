{ ... }:
{
  home.packages = let
    specialisation = pkgs.writeShellScriptBin "lecture" ''
            
    '';
  in [
    specialisation
  ];
}

