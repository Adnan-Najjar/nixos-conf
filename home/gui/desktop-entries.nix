{ ... }:

{
  # Excalidraw
  xdg.desktopEntries.excalidraw = {
    name = "Excalidraw";
    genericName = "Virtual whiteboard for sketching hand-drawn like diagrams";
    categories = [ "Graphics" ];
    exec = "chromium --window-size=1300,1000 --app=https://excalidraw.com";
    icon = "excalidraw";
  };

  # Stirling PDF
  xdg.desktopEntries.stirling-pdf = {
    name = "Stirling PDF";
    genericName = "Launch StirlingPDF and open its WebGUI";
    categories = [ "Office" ];
    exec = "chromium --window-size=1300,1000 --app=http://localhost:2020";
    icon = "stirling-pdf";
  };
}
