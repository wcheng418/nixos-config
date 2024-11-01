{ pkgs, ... }:
{
  home.packages = with pkgs; [
    podman
  ];

  xdg.configFile."containers/registries.conf".text = ''
    [registries.search]
    registries = ['docker.io']
  '';
}
