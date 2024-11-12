{ ... }:

{
  services = {
    upower.enable = true;
    udev.extraRules = ''
      # Enable runtime PM for PCI devices
      ACTION=="add", SUBSYSTEM=="pci", ATTR{power/control}="auto"
      # Enable ASPM for PCI Express links
      ACTION=="add", SUBSYSTEM=="pci", ATTR{power/aspm_policy}="powersave"
    '';
  };

  boot = {
    extraModprobeConfig = ''
      options snd_hda_intel power_save=1
      options iwlwifi power_save=1
      options iwlmvm power_scheme=3
    '';
    kernel.sysctl = {
      "kernel.nmi_watchdog" = 0;
    };
    kernelParams = [ "mem_sleep_default=deep" "pcie_aspm.policy=powersupersave" ];
    # kernelPatches = [{
    #   name = "enable-teo-governor";
    #   patch = null;
    #   extraConfig = ''
    #     CPU_IDLE_GOV_TEO y
    #   '';
    # }];
  };

  powerManagement.enable = true;

  systemd = {
    services = {
      set-cpu-energy-performance-preference = {
        description = "Set CPU energy performance preference";
        after = [ "systemd-modules-load.service" ];
        wantedBy = [ "multi-user.target" ];
        script = ''
          for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
            echo balance_power > $cpu/cpufreq/energy_performance_preference
          done
        '';
        serviceConfig.Type = "oneshot";
      };
      set-battery-threshold = {
        description = "Set battery charge threshold to 60%";
        after = [ "systemd-modules-load.service" ];
        wantedBy = [ "multi-user.target" ];
        script = ''
          echo 60 > /sys/class/power_supply/BAT0/charge_control_end_threshold
        '';
        serviceConfig.Type = "oneshot";
      };
      set-perf-quiet = {
        description = "Sets the default power profile to quiet";
        after = [ "systemd-modules-load.service" ];
        wantedBy = [ "multi-user.target" ];
        script = ''
          echo quiet > /sys/firmware/acpi/platform_profile
        '';
        serviceConfig.Type = "oneshot";
      };
      # set-cpuidle-governor = {
      #   description = "Set CPUIdle governor to TEO";
      #   wantedBy = [ "multi-user.target" ];
      #   script = ''
      #     echo teo > /sys/devices/system/cpu/cpuidle/current_governor;
      #   '';
      #   serviceConfig.Type = "oneshot";
      # };
    };
  };
}
