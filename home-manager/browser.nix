{ pkgs, ... }:

{
  programs = {
    chromium = {
      enable = true;
      package = pkgs.brave;
      commandLineArgs = [
        "--ozone-platform-hint=auto"
      ];
    };
    zathura = {
      enable = true;
      options = {
        "sandbox" = "strict";
        "selection-clipboard" = "clipboard";
      };
      mappings = {
        "<C-i>" = "recolor";
      };
    };
  };
}
