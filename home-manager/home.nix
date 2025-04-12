{ pkgs, ... }:
{
  imports = [
    ./audio.nix
    ./browser.nix
    ./extra.nix
    ./helix.nix
    ./personal.nix
    ./security.nix
    ./shell.nix
    ./sway.nix
    ./video.nix
    ./virt.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "wilson";
  home.homeDirectory = "/home/wilson";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    dconf
    rtorrent
    ffmpeg
    sshfs
    jq
    fx
    nix-index
    nvtopPackages.full
    zip
    unzip
    google-drive-ocamlfuse

    radare2
    binwalk
    nmap
    whois

    glow
    signal-desktop
    parallel
    python3
    # (pkgs.openai-whisper-cpp.overrideAttrs (oldAttrs: {
    #   __noChroot = true;
    #   env = {
    #     NIX_ENFORCE_NO_NATIVE = "0";
    #     GGML_CUDA_ENABLE_UNIFIED_MEMORY = "1";
    #   } // (oldAttrs.env or {});

    #   cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [
    #     (lib.cmakeBool "BUILD_SHARED_LIBS" false)

    #     (lib.cmakeBool "GGML_NATIVE" true)
    #     (lib.cmakeBool "GGML_CUDA_FA_ALL_QUANTS" true)
    #     (lib.cmakeBool "GGML_CUDA_F16" true)
    #     (lib.cmakeBool "GGML_CUDA_GRAPHS" true)
    #     (lib.cmakeFeature "CMAKE_CUDA_ARCHITECTURES" "native")
    #   ];
    # }))
    (pkgs.llama-cpp.overrideAttrs (oldAttrs: {
      __noChroot = true;
      env = {
        NIX_ENFORCE_NO_NATIVE = "0";
        GGML_CUDA_ENABLE_UNIFIED_MEMORY = "1";
      } // (oldAttrs.env or {});

      cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [
        (lib.cmakeBool "GGML_NATIVE" true)
        (lib.cmakeBool "GGML_CUDA_FA_ALL_QUANTS" true)
        (lib.cmakeBool "GGML_CUDA_F16" true)
        (lib.cmakeBool "GGML_CUDA_GRAPHS" true)
        (lib.cmakeFeature "CMAKE_CUDA_ARCHITECTURES" "native")
      ];
    }))

    # It is sometimes useful to fine-tune packages, for example, by applying
    # overrides. You can do that directly here, just don't forget the
    # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  # In your home-manager configuration
  home.file = {
    ".config/nixpkgs/config.nix".text = ''
        {
          allowUnfree = true;
          cudaSupport = true;
        }
      '';
      ".radare2rc".text = ''
        e scr.color=1
      '';
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.home-manager.enable = true;
  home.enableNixpkgsReleaseCheck = false;
}
