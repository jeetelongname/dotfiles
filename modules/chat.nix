{ config, lib, pkgs, ... }:

# ah yes chat. Its fun is it not
# I have given up. nix does not jive with these packages so I go back to the flatpaks
{
  home.packages = with pkgs;
    [
      # discord
      # discord-canary
      # element-desktop

    ];
}
