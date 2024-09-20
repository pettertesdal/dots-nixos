{ pkgs, ... }: {
  imports = [
    ./pdfViewer 
    ./screenshot
  ];
  home.packages = with pkgs; [
  ];
}

