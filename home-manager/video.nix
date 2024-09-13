{ pkgs, ... }:

let power-profile-script = pkgs.stdenv.mkDerivation {
    pname = "mpv-power-profile-script";
    version = "1.0";
    src = pkgs.writeText "power-profile.lua" ''
      function check_power()
          local file = io.open("/sys/class/power_supply/ADP0/online", "r")
          if file then
              local status = file:read("*n")
              file:close()
              if status == 1 then
                  mp.commandv("apply-profile", "slow")
              else
                  mp.commandv("apply-profile", "fast")
              end
          end
      end

      mp.observe_property("pause", "bool", check_power)
    '';
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/share/mpv/scripts
      cp $src $out/share/mpv/scripts/power-profile.lua
    '';
    passthru.scriptName = "power-profile.lua";
  };
in
{
  home.packages = with pkgs; [
    yt-dlp
  ];
  programs.mpv = {
    enable = true;
    config = {
      gpu-api = "vulkan";
      vulkan-queue-count = 8;
      swapchain-depth = 8;
      hls-bitrate = "max";
      cache = "yes";
      cache-pause = false;
      keep-open = "yes";
    };
    profiles = {
      fast = {
        vo = "dmabuf-wayland";
        hwdec = "vaapi";
        vulkan-device = "AMD Radeon 780M (RADV GFX1103_R1)";
        deband = false;
      };
      slow = {
        vo = "gpu-next";
        hwdec = "vaapi";
        vulkan-device = "AMD Radeon 780M (RADV GFX1103_R1)";
        # vulkan-device = "NVIDIA GeForce RTX 4060 Laptop GPU";
        scale = "ewa_lanczos4sharpest";
        dscale = "ewa_lanczos4sharpest";
        video-sync = "display-resample";
        interpolation = true;
        tscale = "oversample";
        deband = true;
        target-colorspace-hint = true;
        af = "rubberband";
      };
    };
    scripts = [ power-profile-script ];
  };
}
