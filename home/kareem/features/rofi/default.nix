{ pkgs, ... }:
{

  xdg.configFile = {
    "rofi".source = ../../../config/rofi;
  };
}
