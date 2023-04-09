{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ]; 

  environment = {
    systemPackages = with pkgs; [
      ed
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
    fish.enable = true;
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
        extraPackages = with pkgs; [];
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
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

  security.rtkit.enable = true;

  boot = {
    loader = {
      efi.canTouchEfiVariables = false;
      systemd-boot.enable = true;
    };
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  nix.settings = {
     warn-dirty = false;
     experimental-features = [ "nix-command" "flakes" ];
  };

  system.stateVersion = "22.11";
}
