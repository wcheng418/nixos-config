{ pkgs, ... }:

{
  security = {
    polkit.enable = true;
    pam.services.swaylock = {};
  };
  security.pam.enableFscrypt = true;
  services.dbus.packages = [ pkgs.gcr ];
}
