{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
  };
  security.sudo.execWheelOnly = true;
}
