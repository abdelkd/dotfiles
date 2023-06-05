{ config, pkgs, ... }:
{
    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + alt + {q,r}" = "bspc {quit,wm -r}"; # quit/restart bspwm
	"super + Escape" = "pkill -USR1 -x sxhkd"; # reload sxhkd config
	"super + q" = "bspc node -c"; # close

	"super + m" = "bspc desktop -l next"; # tiled or monocle layout
	"super + y" = "bspc node newest.marked.local -n newest.!automatic.local"; # send the newest marked node to the newest preselected node
	"super + {_,shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}"; # focus the node in the given direction
	"super + bracket{left,right}" = "bspc desktop -f {prev,next}.local"; # focus the next/previous desktop in the current monitor
	"super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}"; # preselect the direction


	# Desktop


        "super + Return" = "urxvt";
	"super + shift + f" = "firefox";
      };
      extraConfig = "";
    };
}
