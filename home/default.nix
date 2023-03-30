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

  xdg.configFile."kitty/auth.py".source = ./kitty/auth.py;

  xsession = {
    enable = true;

    initExtra = ''
      xrandr --newmode "2256x1504_60.00"  288.30  2256 2424 2672 3088  1504 1505 1508 1556  -HSync +Vsync
      xrandr --addmode Virtual-1 2256x1504_60.00
      xrandr --output Virtual-1 --mode 2256x1504_60.00 --dpi 96 --primary
      feh --bg-scale /home/fetch/.background-image
    '';

    windowManager.i3 = let
      mod = "Mod4";
    in with lib; {
      enable = true;
      config = null;
      extraConfig = builtins.readFile ./i3/config.i3;
    };
  };
}

