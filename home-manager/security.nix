{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pass
    passExtensions.pass-otp
  ];

  programs = {
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
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
      pinentryPackage = pkgs.pinentry-tty;
    };
  };
}
