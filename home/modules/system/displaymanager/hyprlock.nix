{
  programs.hyprlock = {
    enable = true;
  };

  # Security
  security = {
    pam.services.hyprlock = {};
    polkit.enable = true;
  };
}
