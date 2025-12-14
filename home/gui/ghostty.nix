{ ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "TokyoNight";
      font-family = "CaskaydiaMono Nerd Font";
      font-size = 15;
      mouse-hide-while-typing = true;
      window-decoration = "none";
      background-blur = true;
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
