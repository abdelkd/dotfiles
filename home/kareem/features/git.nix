{ config, pkgs, ... }:
{
  config = {
    programs.git = {
      enable = true;
      userName = "abdelkd";
      userEmail = "abdelkarimdjelalda@gmail.com";
      diff-so-fancy.enable = true;
      extraConfig = {
        core = {
          editor = "nvim";
        };
      };

      aliases = {};
    };
  };
}
