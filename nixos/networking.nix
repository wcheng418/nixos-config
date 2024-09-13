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

  services.resolved.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
