{ ... }:
{
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;
    settings = {
      theme = "tokyonight";
      font-family = "CaskaydiaMono Nerd Font";
      font-size = 16;
      mouse-hide-while-typing = true;
      background-blur-radius = 20;
      background-opacity = 0.9;
      maximize = true;
      keybind = [
        "ctrl+shift+v=paste_from_clipboard"
        "ctrl+shift+c=copy_to_clipboard"
      ];
    };
  };
}
