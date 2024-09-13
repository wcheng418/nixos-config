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
    '';
  };
}
