{ inputs, pkgs, ... }:
let
  tokyo-night = pkgs.fetchFromGitHub {
      owner = "Gspr-bit";
      repo = "Spotify-Tokyo-Night-Theme";
      rev = "021a165117dc0bb29c51681e27a1efaa80e750aa";
      sha256 = "gKhY9KnJP0oHnnLAnnvPtEQ06PxLWc67fReWuoNHlLw=";
    };
in
{
  programs.spicetify = {
    enable = true;
    theme = {
        name = "tokyo-night";
        src = tokyo-night;
        appendName = false;
        
        injectCss = true;
        replaceColors = true;
        overwriteAssets = true;
        sidebarConfig = true;
    };

    colorScheme = "Storm";

    enabledExtensions = [];
    };
}
