{ ... }:

{
  networking = {
    useNetworkd = true;
    networkmanager.enable = false;
    wireless.iwd = {
      enable = true;
      # settings = {
      #   Rank = {
      #     BandModifier5Ghz = 2.0;
      #   };
      # };
    };
    hostName = "greenfn";

    wireguard.enable = true;
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
    # domains = [ "~." ];

    # dnsovertls = "opportunistic";
    # dnssec = "allow-downgrade";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
