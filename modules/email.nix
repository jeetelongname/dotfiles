{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      # isync
      msmtp

    ];

  home.file = {
    ".mbsyncrc".source = ../config/email/mbsyncrc;
    ".msmtprc".source = ../config/email/msmtprc;

  };

}
