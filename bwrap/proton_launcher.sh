#!/bin/sh

file_path=$1
directory=$(realpath "$(dirname "$file_path")")

outputs=$(swaymsg -t get_outputs | jq -r '.[] | .name + " " + (.scale|tostring)')

restore_scale() {
  printf '%s\n' "$outputs" | while read -r name scale; do
    swaymsg output "$name" scale "$scale"
  done
}

trap restore_scale TERM

swaymsg output "*" scale 1

# Run the game
bwrap \
  --setenv PULSE_LATENCY_MSEC 60 \
  --setenv VKD3D_SHADER_CACHE_PATH ~/.cache/vkd3d \
  --unshare-all \
  --share-net \
  --die-with-parent \
  --proc /proc \
  --tmpfs /tmp \
  --mqueue /dev/mqueue \
  --dev-bind /dev /dev \
  --ro-bind /sys /sys \
  --ro-bind /var /var \
  --ro-bind /run /run \
  --ro-bind /etc /etc \
  --ro-bind /usr/share /usr/share \
  --ro-bind /usr/bin /usr/bin \
  --ro-bind /usr/lib /usr/lib \
  --ro-bind /usr/lib32 /usr/lib32 \
  --symlink /usr/bin /bin \
  --symlink /usr/lib /lib \
  --symlink /usr/lib /lib64 \
  --symlink /usr/bin /sbin \
  --bind ~/.cache/dxvk-cache-pool ~/.cache/dxvk-cache-pool \
  --bind ~/.cache/vkd3d ~/.cache/vkd3d \
  --bind ~/.local/share/vulkan ~/.local/share/vulkan \
  --bind ~/.local/share/proton-pfx ~/.local/share/proton-pfx \
  --bind ~/.cache/radv_builtin_shaders64 ~/.cache/radv_builtin_shaders64 \
  --bind ~/.cache/mesa_shader_cache ~/.cache/mesa_shader_cache \
  --bind ~/.cache/nvidia ~/.cache/nvidia \
  --bind ~/.nv ~/.nv \
  --ro-bind "$directory" "$directory" \
  --chdir "$directory" \
  /usr/bin/proton "$@"

  restore_scale
