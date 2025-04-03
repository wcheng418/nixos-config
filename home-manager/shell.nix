{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tree
  ];

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      fish_add_path ~/.local/bin
      alias mv='mv -v'
      alias cp='cp -v'
      alias rm='rm -v'
      alias chmod='chmod -v'
      alias nshell="nix-shell --command fish -p"
    '';
  };
}
