{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      keymaps = {
        # Find files using Telescope command-line sugar.
        "<leader>sf" = "find_files";
        "<leader>sg" = "live_grep";
        "<leader><space>" = "buffers";
        "<leader>sh" = "help_tags";
        "<leader>sd" = "diagnostics";

        # FZF like bindings
        #"<C-p>" = "git_files";
        #"<leader>p" = "oldfiles";
        #"<C-f>" = "live_grep";
      };

      settings.defaults = {
        file_ignore_patterns = [
          "^.git/"
          "^.mypy_cache/"
          "^__pycache__/"
          "^output/"
          "^data/"
          "%.ipynb"
        ];
        set_env.COLORTERM = "truecolor";
      };
    };
  };
}
