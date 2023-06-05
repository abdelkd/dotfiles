{ config, pkgs, ... }:
{
  config = {
    services.picom = {
        enable = true;
        inactiveOpacity = 0.8;
      };
    };
}
