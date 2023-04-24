{
  description = "personal nixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    eww-modules.url = "path:home/eww/modules";
  };

  outputs = {
    nixpkgs,
    eww-modules,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    user = "fetch";
    hostname = "nixos";

    pkgMatches = let
      inherit (nixpkgs) lib;
    in
      patterns: pkg: builtins.elem (lib.getName pkg) patterns;

    pkgs = import nixpkgs {
      inherit system;

      overlays = [
        (final: prev: {
          eww-modules = eww-modules.packages."${system}";
        })
      ];

      config = {
        allowUnfreePredicate = pkgMatches [
          "vscode"
          "spotify"
          "discord"
        ];
      };
    };

    localpkgs = import ./localpkgs;

    home-manager = {
      users."${user}" = import ./home;
      useUserPackages = true;
      useGlobalPkgs = true;
      extraSpecialArgs = { inherit localpkgs; };
    };

  in {
    nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
      inherit pkgs system;

      modules = [
        ./system/configuration.nix
        inputs.home-manager.nixosModule { inherit home-manager; }
      ];
    };
  };
}
