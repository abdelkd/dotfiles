{ pkgs, ... }:
{
  services.polybar = {
    enable = true;
    script = "~/.config/polybar/launch.sh";
  };

  xdg.configFile."polybar" = {
    executable = true;
    source = ../../config/polybar;
    recursive = true;
  };
}
