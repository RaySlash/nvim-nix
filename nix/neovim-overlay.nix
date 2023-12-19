{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  # Use this to create a plugin from an input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  mkNeovim = pkgs.callPackage ./mkNeovim.nix {};

  all-plugins = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
    luasnip
    nvim-cmp
    cmp_luasnip
    lspkind-nvim
    cmp-nvim-lsp
    cmp-nvim-lsp-signature-help
    cmp-buffer
    cmp-path
    cmp-nvim-lua
    cmp-cmdline
    cmp-cmdline-history
    diffview-nvim
    gitsigns-nvim
    vim-fugitive
    telescope-nvim
    telescope-fzy-native-nvim
    telescope-file-browser-nvim
    lualine-nvim
    nvim-navic
    statuscol-nvim
    nvim-treesitter-context
    neodev-nvim
    vim-unimpaired
    eyeliner-nvim
    nvim-surround
    nvim-treesitter-textobjects
    nvim-ts-context-commentstring
    nvim-unception
    sqlite-lua
    plenary-nvim
    nvim-web-devicons
    vim-repeat
    (mkNvimPlugin inputs.wf-nvim "wf.nvim")
  ];

  extraPackages = with pkgs; [
    lua-language-server
    nil
  ];
in {
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # You can add as many derivations as you like.
}
