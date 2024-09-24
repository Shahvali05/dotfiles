 { pkgs, config, ... }: {
  programs = {
    neovim = {

      package = pkgs.neovim;
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      extraPackages = with pkgs; [

      ];
      plugins = (with pkgs.vimPlugins; [


      ]) ++ (with pkgs.vimPlugins.nvim-treesitter-parsers; [{
        plugin = pkgs.symlinkJoin {
          name = "nvim-treesitter";
          paths = [
            pkgs.vimPlugins.nvim-treesitter.withAllGrammars
            pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies
          ];
        };
        optional = false;
      }]);

      extraConfig = ''
        set noemoji
      '';
      extraLuaConfig = ''
                ${builtins.readFile ./options.lua}
      '';
    };
  };
}
