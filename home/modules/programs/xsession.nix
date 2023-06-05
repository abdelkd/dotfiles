{ config, pkgs, ... }:
{
  config = {

    home = {
      pointerCursor = {
        name = "Catppuccin-Mocha-Light-Cursors";
        package = pkgs.catppuccin-cursors.mochaLight;
        size = 16;
      };
      # TODO remove
      # file.".Xresources".source = ../../config/Xresources;
    };
    
    xsession = {
      enable = true;
      numlock.enable = true;
      initExtra = ''
	exec ${pkgs.bspwm}/bin/bspwm
      '';

      windowManager = {
        bspwm.enable = true;

      };
    };
  };

}
