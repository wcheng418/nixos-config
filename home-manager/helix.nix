{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nil
    vscode-langservers-extracted
    typescript-language-server
    rust-analyzer
    pyright
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
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          color-modes = true;
          indent-guides.render = true;
          soft-wrap.enable = true;
          lsp = {
            display-messages = true;
            display-inlay-hints = true;
          };
        };
      };
      languages = {
        language = [{
          name = "python";
          language-servers = [ "pyright" "ruff" ];
        }];
        language-server = {
          ruff = {
            command = "${pkgs.ruff}/bin/ruff";
            args = [ "server" "--preview" ];
          };
          typescript-language-server = {
            command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
            args = [ "--stdio" ];
          };
          vscode-html-language-server = {
            command = "${pkgs.vscode-langservers-extracted}/bin/html-languageserver";
            args = [ "--stdio" ];
          };
        };
      };
    };
  };
}
