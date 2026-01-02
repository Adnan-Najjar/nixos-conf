{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Nix
    nil
    nixfmt-classic

    tesseract
    wl-clipboard
    libnotify
    man-pages
    man-pages-posix
    unixtools.xxd
    file
    unzip
    p7zip
    ripgrep
    fd
    ffmpeg
    jq
    htmlq
    btop
    fastfetch
    eza
    tldr
    trash-cli

    android-tools
    imagemagick
    python313Packages.markitdown # MD

    bitwarden-cli
  ];
}
