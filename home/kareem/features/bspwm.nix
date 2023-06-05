{ config, pkgs, ...}:
{
  config = {
    xsession.windowManager.bspwm = {
        enable = true;
    };
    
    services.sxhkd = {
        enable = true;
    };

    home.file = {
      ".Xmodmap".source = ../../config/Xmodmap;
      ".Xresources".source = ../../config/Xresources;
    };

    xdg.configFile = {
      "bspwm".source = ../../config/bspwm;
      "sxhkd".source = ../../config/sxhkd;
    };
  };

}
