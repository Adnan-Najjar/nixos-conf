{
  theme,
  themeName,
  ...
}:

{
  gtk = {
    enable = true;

    gtk2 = {
      theme = {
        name = themeName;
        package = theme;
      };
    };

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
