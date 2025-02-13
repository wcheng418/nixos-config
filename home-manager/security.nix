{ pkgs, ... }:

{
  home.packages = with pkgs; [
    passExtensions.pass-otp
    (pass.withExtensions (ext: with ext; [ pass-otp ]))
    xorg.xauth
  ];

  programs = {
    ssh = {
      enable = true;
      # matchBlocks."*" = {
      #   forwardX11 = true;
      # };
      addKeysToAgent = "yes";
      controlMaster = "auto";
      serverAliveInterval = 3;
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
    gnome-keyring.enable = true;
  };
}
