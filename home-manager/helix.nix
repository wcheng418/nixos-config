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
      languages = {
        language = [{
          name = "python";
          language-servers = [ "pyright" "ruff" ];
        }];
        language-server = {
          ruff = {
            command = "${pkgs.ruff}/bin/ruff";
            args = [ "server" ];
          };
        };
      };
    };
  };
}
