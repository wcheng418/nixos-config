{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pinentry-gnome3
  ];
  home.sessionVariables = {
    SSH_AUTH_SOCK = "${builtins.getEnv "XDG_RUNTIME_DIR"}/ssh-agent.socket";
  };
  
  programs = {
    ssh = {
      enable = true;
      controlMaster = "auto";
    };
    git = {
      enable = true;
      userName = "Pravin Ramana";
      userEmail = "pravinramana25@protonmail.ch";
      signing = { 
        signByDefault = true;
        key = null;
      };
    };
  };
  
  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
    gnome-keyring.enable = true;
    ssh-agent.enable = true;
  };
}
