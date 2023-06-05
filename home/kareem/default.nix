{ inputs, config, pkgs, ... }:
{

  imports = [
    ./features
  ];

  home = {
    username = "kareem";
    homeDirectory = "/home/kareem";
 
    packages = with pkgs; [
      (pkgs.nerdfonts.override { fonts = ["Meslo"  "JetBrainsMono" "DaddyTimeMono" ]; } )
      noto-fonts-emoji
      dejavu_fonts

      rxvt-unicode-unwrapped-emoji
			inputs.st.packages."${pkgs.system}".st-snazzy
    ];

    file = {
      ".wallpaper".source = ../config/nix-wallpaper.png;
    };
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "22.11";
}
