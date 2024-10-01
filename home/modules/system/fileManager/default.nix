{ ... }:
{
  programs.ranger.enable = true;

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      opener = {
        # You can define the opener rules directly under the 'open' attribute
        read = [
          { run = "zathura \"$0\""; orphan = true;}
        ];

        # You should use 'prepend_rules' for specific file types, not redefine 'open'
      };
      open = {
        prepend_rules = [
          { name = ".pdf"; use = "read"; }
        ];
      };
    };
  };
}

