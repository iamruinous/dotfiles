# iamruinous dotfiles

My personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/) and [Nix](https://nixos.org/).

## Installation

### Prerequisites

- [Git](https://git-scm.com/)
- [chezmoi](https://www.chezmoi.io/install/)

### Quick Start

```sh
chezmoi init iamruinous
```

This command will clone the repository. To see what changes will be made to your home directory, you can run:

```sh
chezmoi diff
```

To apply the changes, run:
```sh
chezmoi apply
```

## Nix Configuration

For systems managed with Nix (NixOS or macOS with nix-darwin), see the [`nix-config`](./nix-config) directory.
