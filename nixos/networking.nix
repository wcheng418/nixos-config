{ ... }:

{
  networking = {
    useNetworkd = true;
    networkmanager.enable = false;
    wireless.iwd = {
      enable = true;
      settings = {
        Rank = {
          BandModifier5Ghz = 2.0;
        };
      };
    };
    hostName = "kassandra";

    wireguard.enable = true;
    wg-quick.interfaces = {
      warp = {
        configFile = "/etc/wireguard/warp.conf";
        autostart = false;
      };
    };
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


  services.resolved = {
    enable = true;
    domains = [ "~." ];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
