{ ... }:

{
  services.fstrim.enable = true;

  fileSystems."/tmp" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "mode=1777" "size=100%" ]; # Adjust size as needed
  };
  swapDevices = [
    {
      device = "/dev/zram0";
      priority = 100;
    }
  ];
  zramSwap = {
    enable = true;
    memoryPercent = 100; # Adjust as needed
  };
}
