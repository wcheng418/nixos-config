{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd
    vscode-langservers-extracted
    typescript-language-server
    rust-analyzer
    pyright
    gopls
    markdown-oxide
  ];

  programs = {
    ruff = {
      enable = true;
      settings = {};
    };

    helix = {
      defaultEditor = true;
      enable = true;
      settings = {
        theme = "dracula";
        editor = {
          line-number = "relative";
          color-modes = true;
          bufferline = "multiple";
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          indent-guides.render = true;
          soft-wrap.enable = true;
          lsp = {
            display-messages = true;
            display-inlay-hints = true;
          };
        };
      };
      themes = {
        dracula = {
          inherits = "dracula";
          "ui.background" = {};
        };
      };
      languages = {
        language = [
        {
          name = "nix";
          language-servers = [ "nixd" ];
        }
        {
          name = "python";
          language-servers = [ "pyright" "ruff" ];
        }];
        language-server = {
          nixd = {
            command = "${pkgs.nixd}/bin/nixd";
            args = [];
          };

          ruff = {
            command = "${pkgs.ruff}/bin/ruff";
            args = [ "server" ];
          };
        };
      };
    };
  };
}
