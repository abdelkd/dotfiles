{ inputs, lib, config, pkgs, ... }: {
  home.packages = with pkgs; [
    gdb
    # checksec
    pwntools
    file
  ];
}
