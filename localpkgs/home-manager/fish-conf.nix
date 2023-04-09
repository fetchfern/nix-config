{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.programs.fish-conf;
in
{
  options.programs.fish-conf = {
    enable = mkEnableOption "fish: a command-line shell for the 90s";

    # todo: fish plugins

    configSrc = mkOption {
      type = types.path;
      default = null;
    };
  };

  config = mkIf cfg.enable {
    xdg = {
      configFile."fish" = {
        source = cfg.configSrc;
        recursive = true;
      };
	  };
  };
}
