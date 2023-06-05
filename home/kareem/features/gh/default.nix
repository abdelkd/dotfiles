{ pkgs, ... }:
{
  programs.gh = {
      enable = true;
      settings = {
          protocol = "ssh";
          prompt = "enabled";
        };
    };
}
