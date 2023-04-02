{ config, lib, pkgs, localpkgs, ... }: {
  imports = [ localpkgs.home-manager.neovim-conf ];

  home = {
    packages = with pkgs; [
      keepassxc
      xclip
      gh
      killall
      neovide
    ];

    stateVersion = "22.11";
  };
  
  programs = {
    feh.enable = true;
    gpg.enable = true;
  
    neovim-conf = {
      enable = true;

      configSrc = ./nvim;

      plugins = with pkgs.vimPlugins; [
        vim-nix
        nvim-lspconfig
        rust-tools-nvim
        gruvbox
        feline-nvim
      ];

      treesitter = {
        enable = true;
        grammars = plugins: with plugins; [
          nix
          rust
          c
        ];
      };
    };

    kitty = {
      enable = true;
      extraConfig = builtins.readFile ./kitty/kitty.conf;
    };

    nushell = {
      enable = true;

      configFile = { source = ./nu/config.nu; };
      envFile = { source = ./nu/env.nu; };
    };

    git = {
      enable = true;
      userName = "fetchfern";
      userEmail = "fetchfern@proton.me";

      iniContent = {
        core.editor = "nvim";
      };

      signing = {
        signByDefault = true;
        key = "3A33FE033DCD8340";
      };
    };

    firefox = {
      enable = true;
      
      profiles = {
         fetch = {
           settings = {};  
        };
      };
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      #enableBashIntegration = true; # sets GPG_TTY for pinentry-curses
      pinentryFlavor = "curses";
    };

    polybar = let
      package = pkgs.polybar.override {
        i3Support = true;
      };
    in {
      enable = true;
      inherit package;
      config = ./polybar/config.ini;
      script = ""; # WORKAROUND: polybar must be started
                   # after i3 for the i3 workspaces feature
                   # to work, for that reason polybar is
                   # started in the i3 config file.
    };

    picom = {
      enable = true;
    };
  };

  xsession = {
    enable = true;

    windowManager.i3 = let
      mod = "Mod4";
    in with lib; {
      enable = true;
      config = null;
      extraConfig = builtins.readFile ./i3/config;
    };
  };
}

