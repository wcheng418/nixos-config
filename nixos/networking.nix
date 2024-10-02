{ ... }:

{
  networking = {
    useNetworkd = true;
    networkmanager.enable = false;
    wireless.iwd.enable = true;
    hostName = "zephyrus";
  };

  systemd.network = {
    enable = true;

    networks = {
      "40-wired" = {
        matchConfig = {
          Type = "ether";
        };
        networkConfig = {
          DHCP = "yes";
        };
        linkConfig = {
          RequiredForOnline = "routable";
        };
      };
      "50-wireless" = {
        matchConfig = {
          Type = "wlan";
        };
        networkConfig = {
          DHCP = "yes";
        };
        linkConfig = {
          RequiredForOnline = "routable";
        };
      };
    };
  };

  networking.nameservers = [ "1.1.1.1#one.one.one.one" "9.9.9.9#dns.quad9.net" ];
  services = {
    resolved = {
      enable = true;
      llmnr = "resolve";
      dnssec = "allow-downgrade";
      dnsovertls = "opportunistic";
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
