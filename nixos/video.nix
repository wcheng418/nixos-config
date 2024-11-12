{ config, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  boot.kernelModules = [ "nvidia-uvm" ]; # current nvidia-uvm is not loaded at boot, eventually this will be fixed: https://github.com/NixOS/nixpkgs/issues/334180

  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      open = true;
      dynamicBoost.enable = true;

      powerManagement = {
        enable = true;
        finegrained = true;
      };

      prime = {
        offload.enable = true;
        reverseSync.enable = true;

        amdgpuBusId = "PCI:65:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
