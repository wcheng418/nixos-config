{ ... }:
{
  programs.steam = {
    enable = true;
    extest.enable = true;
  };
  hardware = {
    steam-hardware.enable = true;
    xone.enable = true;
  };
}
