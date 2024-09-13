{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    mullvad
    sbctl
    cryptsetup
  ];
  networking.firewall.enable = true;
  system.activationScripts.secureboot_permissions = {
    text = ''
      chmod 600 /etc/secureboot.img
      chown root:root /etc/secureboot.img
    '';
  };
  # systemd.services.secureboot = {
  #   description = "Mount LUKS-encrypted secureboot image";
  #   after = [ "local-fs.target" ];
  #   wantedBy = [ "multi-user.target" ];

  #   serviceConfig = {
  #     Type = "oneshot";
  #     RemainAfterExit = true;
  #     StandardInput = "tty";
  #     StandardOutput = "tty";
  #     TTYPath = "/dev/console";
  #     ExecStartPre = "${pkgs.util-linux}/bin/losetup /dev/loop0 /etc/secureboot.img";
  #     ExecStart = ''
  #       ${pkgs.cryptsetup}/bin/cryptsetup open /dev/loop0 secureboot
  #       ${pkgs.util-linux}/bin/mount /dev/mapper/secureboot /etc/secureboot
  #     '';
  #     ExecStop = ''
  #       ${pkgs.util-linux}/bin/umount /etc/secureboot
  #       ${pkgs.cryptsetup}/bin/cryptsetup close secureboot
  #       ${pkgs.util-linux}/bin/losetup -d /dev/loop0
  #     '';
  #   };
  # };
  # fileSystems."/etc/secureboot" = {
  #   device = "/dev/mapper/secureboot";
  #   fsType = "ext4";
  #   options = [ "noatime" ];
  # };
  # systemd.tmpfiles.rules = [
  #   "d /etc/secureboot 0755 root root"
  # ];
  security = {
    polkit.enable = true;
    pam = {
      services.swaylock = {};
      enableFscrypt = true;
    };
  };
  services = {
    dbus.packages = [ pkgs.gcr ];
    mullvad-vpn = {
      enable = true;
    };
  };
}
