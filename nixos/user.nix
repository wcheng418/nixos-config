{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pravin = {
    isNormalUser = true;
    description = "pravin";
    extraGroups = [ "wheel" ];
  };
  
  services.dbus.package = pkgs.dbus-broker;
}
