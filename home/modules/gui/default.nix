{ pkgs, ... }: {
  imports = [
    ./pdfViewer 
    ./screenshot
    ./ide
  ];
  home.packages = with pkgs; [
  ];
}

