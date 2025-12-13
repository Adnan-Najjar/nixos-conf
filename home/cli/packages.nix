{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tesseract
    wl-clipboard
    libnotify
    man-pages
    man-pages-posix
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
  ];
}
