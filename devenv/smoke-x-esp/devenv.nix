{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  # https://devenv.sh/basics/
  env.GREET = "smoke-x-esp";

  dotenv.enable = true;

  # https://devenv.sh/packages/
  packages = with pkgs; [
    git
    cmake
    ninja
    ccache
    libffi
    openssl
    dfu-util
    libusb1
  ];

  # https://devenv.sh/languages/
  languages.python.enable = true;
  languages.python.version = "3.13.5";

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  enterShell = ''
    hello
    git --version
    if [ -f ./esp/esp-idf/export.sh ]; then
      source ./esp/esp-idf/export.sh
    fi
  '';

  # https://devenv.sh/tasks/
  tasks = {
    "smxesp:checkout-smoke-x-receiver" = {
      exec = ''
        git clone --recurse-submodules https://github.com/G-Two/smoke-x-receiver.git
      '';
      status = ''
        test -d smoke-x-receiver
      '';
      after = ["smxesp:install-esp-idf"];
    };
    "smxesp:checkout-esp-idf" = {
      exec = ''
        mkdir -p ./esp;
        cd esp;
        git clone -b release/v4.4 --recursive https://github.com/espressif/esp-idf.git
      '';
      status = ''
        test -d esp
      '';
      before = ["devenv:enterShell" "devenv:enterTest"];
    };
    "smxesp:install-esp-idf" = {
      exec = ''
        cd ./esp/esp-idf
        ./install.sh esp32s3
        pip install -r requirements.txt
      '';
      status = ''
        test ! -d .espressif
      '';
      after = ["smxesp:checkout-esp-idf"];
    };
  };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
