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
    android-tools
    imagemagick
    ghostscript_headless # PDF
    python313Packages.markitdown # MD
    ffmpeg
    jq
    htmlq
    btop
    fastfetch
    eza
    tldr
    trash-cli
    fahclient
  ];
}
