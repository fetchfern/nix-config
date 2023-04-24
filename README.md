# nix-config

My personal x86\_64-linux flake-based NixOS configuration.

## Building

```
# ./bin/build
```

This script passes all flags to `nixos-rebuild`, so you can give it `--show-trace` for example.

## Todo

- fix GPG integration with the fish shell (`GPG_TTY`)
- neovim completions (coq.nvim?)
- finish up/separate tmux configuration
- program launcher (watchtower project)
- fix polybar modules and add battery/sound
- find easily reproducible solution for secrets (gpg keypairs, gh auth, etc)
- setup SSH with git

## License

This repository's entire content is released into the Public Domain. See [LICENSE](LICENSE).

