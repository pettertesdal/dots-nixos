{ ... }:
{
  programs.nixvim.plugins.luasnip = {
    enable = true;
    settings = {
      enable_autosnippets = true;
      store_selection_keys = "<Tab>";
    };
    fromLua = [
          {}
          {
            paths = ./snippets;
          }
    ];
  };
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<Tab>";
      action = "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'";
      options = {
        silent = true;
        expr = true;
      }
    };
  ];
}
