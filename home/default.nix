{ config, lib, pkgs, localpkgs, ... }: {
  imports = with localpkgs; [
    home-manager.neovim-conf
  ];

  home = {
    packages = with pkgs; [
      keepassxc
      xclip
      gh
      killall
      neovide
      discord
      vscode
      maim
      slop
      bacon
      krita
      tree-sitter
      vim
      audacity
      spotifyd
      spotify
      eww
      file
      sxiv
      ffmpeg
    ] ++ [
      (callPackage localpkgs.tmux-dev { })
    ] ++ (with eww-modules; [
      i3ws
      notif
    ]);

    stateVersion = "22.11";
  };
  
  programs = {
    feh.enable = true;
    gpg.enable = true;

    tmux = {
      enable = true;
      escapeTime = 0;
      keyMode = "vi";
      resizeAmount = 4;
      extraConfig = ''
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        set -g mouse on

        set-option -g status-style fg=black,bg=default,dim
        set -g status-left ""
        set -g status-right ""

        setw -g window-status-format "[#I:#W-]"
        setw -g window-status-style bg=default,fg=color246,dim
        setw -g window-status-current-format "[#I:#W*]"
        setw -g window-status-current-style bg=default,fg=color253,dim,bold

        set-option -g pane-border-style fg=black
        set-option -g pane-active-border-style fg=black

        set-option -g message-style fg=brightred,bg=black

        set-option -g display-panes-active-colour brightred
        set-option -g display-panes-colour blue

        set -g visual-activity off
        set -g visual-bell off
        set -g visual-silence off
        set-window-option -g monitor-activity off
        set -g bell-action none
      '';
    };

    direnv = {
      enable = true;
      config.global.disable_stdin = true;
      nix-direnv.enable = true;
    };
  
    neovim-conf = {
      enable = true;

      configSrc = ./nvim;

      plugins = with pkgs.vimPlugins; [
        vim-nix
        nvim-lspconfig
        rust-tools-nvim
        rust-vim
        feline-nvim
        instant-nvim
        editorconfig-nvim
        coq_nvim
        nightfox-nvim
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
      enableFishIntegration = true; # sets GPG_TTY for pinentry-curses
      pinentryFlavor = "curses";
    };

    polybar = {
      enable = true;
      package = pkgs.polybar.override { i3Support = true; };
      config = ./polybar/config.ini;
      script = ""; # WORKAROUND: polybar must be started
                   # after i3 for the i3 workspaces feature
                   # to work, for that reason polybar is
                   # started in the i3 config file.
    };

    picom = { enable = true; };
  };

  xsession = {
    enable = true;

    windowManager.i3 = {
      enable = true;
      config = null;
      extraConfig = builtins.readFile ./i3/config;
    };
  };

  xdg = {
    configFile = let
      configDir = dirname: { source = dirname; recursive = true; };
    in {
      "eww" = configDir ./eww/cfg;
      "fish" = configDir ./fish;
    };
  };
}
