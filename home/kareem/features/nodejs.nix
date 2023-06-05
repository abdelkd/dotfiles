{ pkgs, ... }:
{
  home.packages = with pkgs.nodePackages; [
    pnpm

    graphql-language-service-cli
    vscode-langservers-extracted
  ];
}
