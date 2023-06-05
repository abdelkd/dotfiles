{ config, pkgs, ... }:
{
  # TODO write starship's config with nix
  home.packages = [pkgs.starship];
  xdg.configFile."starship.toml".source = ../../config/starship.toml;
}
