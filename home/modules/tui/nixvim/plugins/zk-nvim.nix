{
  programs.nixvim = {
    plugins.zk = {
      enable = true;
      settings = {
        lsp = {
          auto_attach = {
            enabled = true;
            filetypes = [
              "markdown"
            ];
          };
          config = {
            cmd = [
              "zk"
              "lsp"
            ];
            name = "zk";
          };
        };
        picker = "telescope";
      };
    };
  };
}
