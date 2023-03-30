{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ]; 

  environment = {
    shells = [ pkgs.nushell ];
    systemPackages = with pkgs; [
      ed
      wget
    ];
  };

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  users.users.fetch = {
    shell = pkgs.nushell;
    isNormalUser = true;
    home = "/home/fetch";
    description = "fetch";
    extraGroups = [ "networkmanager" "wheel" ];
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

  services = {
    xserver = {
       enable = true;
       layout = "us";
       videoDrivers = [ "modesetting" "fbdev" ];
       windowManager.i3 = {
         enable = true;
         extraPackages = with pkgs; [];
       };
    };
  };

  nix.settings = {
     warn-dirty = false;
     experimental-features = [ "nix-command" "flakes" ];
  };

  system.stateVersion = "22.11";
}
