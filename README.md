# nix-config

My personal x86\_64-linux flake-based NixOS configuration.

## Building

```sh
# ./bin/build
```

This script passes all flags to `nixos-rebuild`, so you can give it `--show-trace` for example.

## Quick start

To get a freshly installed NixOS to use this configuration:

1. Install git and clone the repository
2. Generate a hardware configuration with the [provided script](./bin/generate-hw-config)
3. Rebuild your system with the [build script](./bin/build)
4. Set a password for the user account
5. Setup Github credentials with the `gh` cli
6. Setup GPG keys for git commit signing

## License

This repository's entire content is released into the Public Domain. See [LICENSE](LICENSE).

