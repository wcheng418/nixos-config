{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pravin = {
    isNormalUser = true;
    description = "pravin";
    extraGroups = [ "wheel" ];
  };
  xdg.portal = {
  	enable = true;
  	wlr.enable = true;
  	extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  	config = {
  		common = { 
  		default = [ "gtk" ]; 
  		"org.freedesktop.impl.portal.Screencast" = [ "wlr" ];
  		"org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
  		};
  	};
  };
}
