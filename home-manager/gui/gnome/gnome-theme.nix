{ theme, themeName, ... }:

{
  home.gtk = {
    enable = true;
    gtk3.theme = {
      name = themeName;
      package = theme;
    };
    gtk4.theme = {
      name = themeName;
      package = theme;
    };
  };
}
