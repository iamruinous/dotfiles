# smoke-x-esp devenv

This directory contains a `devenv.nix` configuration for managing the
ESP-IDF environment required to build the `smoke-x-receiver` project.

## Usage

To enter the development environment, navigate to this directory and
run:

```sh
devenv shell
```

This will drop you into a shell with the `esp-idf` toolchain and all
necessary dependencies available. You can then proceed to build the
`smoke-x-receiver` firmware.
