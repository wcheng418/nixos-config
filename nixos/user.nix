{ ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pravin = {
    isNormalUser = true;
    description = "pravin";
    extraGroups = [ "wheel" ];
  };
}
