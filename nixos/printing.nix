{ ... }:
{
  services = {
    printing = {
      enable = true;
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
    };
    system-config-printer.enable = true;
  };
}
