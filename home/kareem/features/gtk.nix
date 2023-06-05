{ pkgs, ... }:
{
  gtk = {
      enable = true;
      theme = {
          name = "Catppuccin";
          package = pkgs.catppuccin-gtk;
        };
    };
}
