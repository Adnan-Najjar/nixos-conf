{ pkgs-unstable, ... }:
let
  discord-bypass = pkgs-unstable.stdenv.mkDerivation {
    name = "libdiscordbypass";
    src = ./libdiscordbypass.tar.gz;
    installPhase = ''
      mkdir -p $out/lib
      cp libdiscordbypass.so $out/lib/
    '';
  };

  myDiscord = pkgs-unstable.discord.overrideAttrs (oldAttrs: {
    desktopItem = oldAttrs.desktopItem.override {
      exec = "env LD_PRELOAD=${discord-bypass}/lib/libdiscordbypass.so discord";
    };
  });
in
{
  home.packages = [
    myDiscord
  ];
}
