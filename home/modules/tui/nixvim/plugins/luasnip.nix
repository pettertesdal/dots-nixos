{}:
{
  programs.nixvim.plugins.luasnip = {
    enable = true;
    settings = {
    };
    fromLua = 
    ''
      [
        {
          paths = ./snippets;
        }
      ]
    '';
  }
}
