{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ]; 

  environment = {
    systemPackages = with pkgs; [
      vim
      wget
    ];
  };

  users.users.fetch = {
    shell = pkgs.fish;
    isNormalUser = true;
    home = "/home/fetch";
    description = "fetch";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs = {
    fish = { enable = true; };
  };

  services = {
    xserver = {
      enable = true;

      layout = "us";
      videoDrivers = [ "modesetting" ];

      libinput = {
        enable = true;

        touchpad = {
          tapping = false;
          naturalScrolling = true;
          disableWhileTyping = true;
        };
      };

      windowManager.i3 = {
        enable = true;
      };
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      twemoji-color-font
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      iosevka
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
    
    fontconfig = {
      defaultFonts = {
        monospace = [ "Iosevka" "Noto Sans Mono" ];
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        emoji = [ "Twemoji Color Emoji" "Noto Color Emoji" ];
      };
    };
  };

  boot = {
    loader = {
      efi.canTouchEfiVariables = false;
      systemd-boot = { enable = true; };
    };
  };

  networking.hostName = "nixos";
  networking.networkmanager = { enable = true; };

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  nix.settings = {
    warn-dirty = false;
    experimental-features = [ "nix-command" "flakes" ];
  };

  security = {
    rtkit = { enable = true; };
  };

  sound.enable = true;

  system.stateVersion = "22.11";
}
