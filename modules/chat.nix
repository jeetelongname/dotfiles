{ config, lib, pkgs, ... }:

# ah yes chat. Its fun is it not
{
  home.packages = with pkgs; [
    # discord
    discord-canary
    element-desktop

  ];
}
