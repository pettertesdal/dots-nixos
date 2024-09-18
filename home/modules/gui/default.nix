{ pkgs, ... }: {
  imports = [
    ./inkscape
    ./pdfViewer 
    ./screenshot
  ]
  home.packages = with pkgs; [
    obsidian
  ];
}

