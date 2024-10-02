{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vulkan-loader
  ];

  nixpkgs.config.cudaCapabilities = [ "8.9" ];


  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    graphics = {
      enable = true;
      extraPackages = [ pkgs.mesa.drivers ];
    };
    
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      open = true;
      dynamicBoost.enable = true;

      powerManagement = {
        enable = true;
        finegrained = true;
      };

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        reverseSync.enable = true;

        amdgpuBusId = "PCI:65:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
