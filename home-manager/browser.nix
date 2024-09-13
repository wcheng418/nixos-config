{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--ozone-platform-hint=auto"
      "--enable-native-gpu-memory-buffers"
      "--enable-features=RawDraw"
    ];
  };
}
