{ config, pkgs, ... }:
{
  config = {
    services = {

      earlyoom = {
        enable = true;
        freeMemKillThreshold = 20;
      };
      
      xserver = {
        enable = true;

        # Enable touchpad
        synaptics = {
          enable = true;
        };

        layout = "fr";
        xkbVariant = "azerty";
        videoDrivers = [ "intel" ];
        excludePackages = [ pkgs.xterm ];
  
  
        windowManager.bspwm.enable = true;
        desktopManager = {
          xterm.enable = false;
        };

        displayManager = {
          defaultSession = "none+bspwm";
          lightdm.enable =  true;
        	lightdm.greeters.mini = {
            enable = true;
            user = "kareem"; 
          };
        };
      };
 
    };
  };
}
