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
      matchBlocks."*" = {
        # forwardX11 = true;
      };
      addKeysToAgent = "yes";
      controlMaster = "auto";
      serverAliveInterval = 3;
    };

    git = {
      enable = true;
      userName = "Wilson Cheng";
      userEmail = "wilson.cheng.007@gmail.com";
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
