{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    mullvad
    sbctl
    cryptsetup
  ];
  networking.firewall.enable = true;
  system.activationScripts.secureboot_permissions = {
    text = ''
      chmod 600 /etc/secureboot.img
      chown root:root /etc/secureboot.img
    '';
  };
  security = {
    polkit.enable = true;
    pam = {
      services.swaylock = {};
      enableFscrypt = true;
    };
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services = {
    dbus.packages = [ pkgs.gcr ];
    mullvad-vpn = {
      enable = true;
    };
  };
}
