{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ mu ];
  programs = {
    msmtp.enable = true;
    mbsync.enable = true; # errors out on me :(
  };
  home.file = {
    ".mbsyncrc".source =
      config.lib.file.mkOutOfStoreSymlink ../config/email/mbsyncrc;
    ".msmtprc".source =
      config.lib.file.mkOutOfStoreSymlink ../config/email/msmtprc;

  };

}
