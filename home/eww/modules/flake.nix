{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    naersk.url = "github:nix-community/naersk/master";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = {
    nixpkgs,
    rust-overlay,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      overlays = [ (import rust-overlay) ];
    };

    toolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;

    naersk = pkgs.callPackage inputs.naersk {
      cargo = toolchain;
      rustc = toolchain;
    };
  in {
    packages."${system}" = {
      i3ws = naersk.buildPackage {
        pname = "ewwmod_i3ws";
        src = ./.;
      };

      notif = naersk.buildPackage {
        pname = "ewwmod_notif";
        src = ./.;
      };

      netqual = naersk.buildPackage {
        pname = "ewwmod_netqual";
        src = ./.;
      };

      netessid = naersk.buildPackage {
        pname = "ewwmod_netessid";
        src = ./.;
      };

      process_graphics = naersk.buildPackage {
        pname = "process_graphics";
        src = ./.;
      };
    };

    devShell."${system}" = pkgs.mkShell {
      buildInputs = [ toolchain ];
    };
  };
}
