{ ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "tokyonight";
      font-family = "CaskaydiaMono Nerd Font";
      font-size = 15;
      mouse-hide-while-typing = true;
      background-blur-radius = 20;
      background-opacity = 0.9;
      maximize = true;
      keybind = [
        "alt+one=unbind"
        "alt+two=unbind"
        "alt+three=unbind"
        "alt+four=unbind"
      ];
    };
  };
}
