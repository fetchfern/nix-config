{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.programs.neovim-conf;

  allPlugins = cfg.plugins ++ (if cfg.treesitter.enable then [
    (if cfg.treesitter.useAllGrammars then
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    else
      pkgs.vimPlugins.nvim-treesitter.withPlugins cfg.treesitter.grammars)
  ] else [ ]);

  nvimConfig = pkgs.neovimUtils.makeNeovimConfig {
    withPython3 = true;
    withNodeJs = true;
    withRuby = false;
    plugins = allPlugins;
    customRC = "";
  };

  nvimPkg = pkgs.wrapNeovimUnstable cfg.package (nvimConfig // {
    wrapperArgs = (lib.escapeShellArgs nvimConfig.wrapperArgs);
    wrapRc = false;
  });
in
{
  options.programs.neovim-conf = {
    enable = mkEnableOption "Neovim: an hyperextensible Vim-based text editor.";

    package = mkOption {
      type = types.package;
      default = pkgs.neovim-unwrapped;
    };

    treesitter = mkOption {
      type = types.submodule {
        options = {
          enable = mkEnableOption "Treesitter";

          useAllGrammars = mkOption {
            type = types.bool;
            default = false;
          };

          grammars = mkOption {
            type = hm.types.selectorFunction;
            default = plugins: [ ];
          };
        };
      };

      default = null;
    };

    plugins = mkOption {
      type = types.listOf types.package;
      default = [ ];
    };

    configSrc = mkOption {
      type = types.path;
      default = null;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ nvimPkg ];

    xdg = {
      configFile."nvim" = {
        source = cfg.configSrc;
        recursive = true;
      };

      dataFile = let
        dataFunctor = name: val: {
      	  "nvim/site" = {
	    source = pkgs.vimUtils.packDir nvimConfig.packpathDirs;
	  };
        };
      in lib.mkMerge (lib.mapAttrsToList dataFunctor nvimConfig.packpathDirs);

    };
  };
}
