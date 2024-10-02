{ pkgs, ... }:

{
  programs = {
    chromium = {
      enable = true;
      package = pkgs.brave;
      commandLineArgs = [
        "--ozone-platform-hint=auto"
        "--enable-native-gpu-memory-buffers"
        "--enable-features=VaapiVideoDecoder"
      ];
    };
    zathura = {
      enable = true;
      options = {
        "selection-keyboard" = "clipboard";
      };
      mappings = {
        "<C-i>" = "recolor";
      };
    };
  };
}
