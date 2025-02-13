{ pkgs, ... }:

{
  programs = {
    chromium = {
      enable = true;
      package = pkgs.brave;
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
