{ pkgs, ... }:

let power-profile-script = pkgs.stdenv.mkDerivation {
    pname = "mpv-power-profile-script";
    version = "1.0";
    src = pkgs.writeText "power-profile.lua" ''
      function check_power()
          local ac_status = 0
          local usbc_status = 0
          
          local ac_file = io.open("/sys/class/power_supply/ADP0/online", "r")
          if ac_file then
              ac_status = tonumber(ac_file:read("*n")) or 0
              ac_file:close()
          end

          local usbc_file = io.open("/sys/class/power_supply/ucsi-source-psy-USBC000:001/online", "r")
          if usbc_file then
              usbc_status = tonumber(usbc_file:read("*n")) or 0
              usbc_file:close()
          end

          if ac_status == 1 and usbc_status == 0 then
              mp.command_native({"apply-profile", "slow"})
              mp.msg.info("Applied 'slow' profile - running on main AC power")
          else
              mp.command_native({"apply-profile", "fast"})
              mp.msg.info("Applied 'fast' profile - running on battery or USB-C power")
          end
      end

      mp.observe_property("pause", "bool", function(name, value)
          local status, err = pcall(check_power)
          if not status then
              mp.msg.error("Error checking power status: " .. tostring(err))
          end
      end)

      mp.register_event("file-loaded", function()
          local status, err = pcall(check_power)
          if not status then
              mp.msg.error("Error checking power status: " .. tostring(err))
          end
      end)
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
    imv
    mpvScripts.mpris
  ];
  programs = {
    aria2 = {
      enable = true;
      settings = {
        file-allocation = "falloc";
        max-connection-per-server = 16;
        conditional-get = true;
        enable-mmap = true;
      };
    };
    yt-dlp = {
      enable = true;
      settings = {
        embed-metadata = true;
        downloader = "aria2c";
      };
    };
    mpv = {
      enable = true;
      config = {
        gpu-api = "vulkan";
        vulkan-queue-count = 8;
        swapchain-depth = 8;
        hls-bitrate = "max";
        cache = "yes";
        cache-pause = false;
        keep-open = "yes";
        demuxer-max-bytes = "32GiB";
        ad-lavc-threads = 0;
      };
      bindings = {
        "Alt+=" = "add video-zoom 0.1";
        "Alt+-" = "add video-zoom -0.1";
        "Alt+h" = "add video-pan-x -0.05";
        "Alt+l" = "add video-pan-x 0.05";
        "Alt+j" = "add video-pan-y 0.05";
        "Alt+k" = "add video-pan-y -0.05";
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
          vulkan-device = "NVIDIA GeForce RTX 4060 Laptop GPU";
          hwdec = "nvdec";
          scale = "ewa_lanczos4sharpest";
          dscale = "ewa_lanczos4sharpest";
          tscale = "oversample";
          video-sync = "display-resample";
          interpolation = true;
          temporal-dither = true;
          deband = true;
          target-colorspace-hint = true;
          af = "rubberband";
          hr-seek = true;
        };
      };
      scripts = [ power-profile-script ];
    };
  };
}
