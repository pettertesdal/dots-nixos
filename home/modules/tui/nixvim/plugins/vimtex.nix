{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.vimtex = {
      enable = true;
      texlivePackage = pkgs.texlive.combined.scheme-full;

      settings = {
        view_method = "zathura";

        compiler_method = "latexmk";
        log_verbose = 1;
        quickfix_enabled = true;
        quickfix_open_on_warning = false;

        # Ignore undesired errors and warnings
        quickfix_ignore_filters = [
          "Underfull"
          "Overfull"
          "specifier changed to"
          "Token not allowed in a PDF string"
        ];

      };
    };

    files."after/ftplugin/tex.lua".keymaps = [
      {
        mode = "n";
        key = "m";
        action = ":VimtexCompile<cr>";
      }
    ];

    autoCmd = [
      {
        event = ["BufEnter" "BufWinEnter"];
        pattern = "*.tex";
        command = "set filetype=tex \"| VimtexTocOpen";
      }

      # Folding
      #{
      #  event = "FileType";
      #  pattern = ["tex" "latex"];
      #  callback.__raw = ''
      #    function ()
      #    print("Callback triggered for folding settings")
      #      vim.o.foldmethod = "expr"
      #vim.o.foldexpr = 'vimtex#fold#level(v:lnum)'
      #vim.o.foldtext = 'vimtex#fold#text()'
      #      end
      #    '';
      # }

      # Compile on initialization
      {
        event = "User";
        pattern = "VimtexEventInitPost";
        callback = "vimtex#compiler#compile";
      }
      {
        event = "User";
        pattern = "VimtexEventInitPost";
        command = "set conceallevel=1";
      }
      {
        event = "User";
        pattern = "VimtexEventInitPost";
        command = "";
      }
      {
        event = "User";
        pattern = "VimtexEventInitPost";
        command = "set wrap";
      }

      # Cleanup on exit
      {
        event = "User";
        pattern = "VimtexEventQuit";
        command = "call vimtex#compiler#clean(0)";
      }
    ];
  };
}
