{
  description = "personal nixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    user = "fetch";
    hostname = "nixos";

    pkgMatches = patterns: pkg: builtins.elem (pkg) patterns;

    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfreePredicate = pkgMatches [
          "spotify"
        ];
      };
    };

    localpkgs = import ./localpkgs;
  in {
    nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./system/configuration.nix
        home-manager.nixosModule {
          home-manager = {
            users."${user}" = import ./home;
            useUserPackages = true;
            useGlobalPkgs = true;
            extraSpecialArgs = { inherit localpkgs; };
          };
        }
      ];
    };
  };
}
