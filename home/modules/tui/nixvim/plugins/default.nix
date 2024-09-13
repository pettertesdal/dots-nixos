{
  imports = [
    ./barbar.nix
    ./comment.nix
    #./floaterm.nix
    ./harpoon.nix
    ./lsp.nix
    ./lualine.nix
    #./markdown-preview.nix
    #./neorg.nix
    ./neo-tree.nix
    ./startify.nix
    ./tagbar.nix
    ./telescope.nix
    ./treesitter.nix
    ./vimtex.nix
  ];

  programs.nixvim = {
    colorschemes.gruvbox.enable = true;

  };
}
