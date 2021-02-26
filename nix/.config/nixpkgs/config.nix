# { pkgs, ... }:

# {
#   nixpkgs.config = { allowUnfree = true; };
#   packageOverrides = pkgs:
#     with pkgs; rec {
#       myProfile = writeText "my-profile" ''
#         export PATH=$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/sbin:/bin:/usr/sbin:/usr/bin
#         export MANPATH=$HOME/.nix-profile/share/man:/nix/var/nix/profiles/default/share/man:/usr/share/man
#       '';
#       pack = pkgs.buildEnv {
#         name = "my-packages";
#         paths = [ caddy nix nixfmt scrcpy shfmt ];

#       };
#       extraOutputsToInstall = [ "man" "doc" ];
#       pathsToLink = [ "/share" "/bin" ];
#     };
# }
{ }
