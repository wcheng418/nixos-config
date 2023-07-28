#!/bin/sh

# Function to restore the original scale of all outputs
restore_scale() {
    printf '%s\n' "$outputs" | while read -r name scale; do
        swaymsg output "$name" scale "$scale"
    done
}

# Trap signals to ensure that the original scale is always restored
trap restore_scale EXIT KILL TRAP TERM HUP

# Get the display names and their scales
outputs=$(swaymsg -t get_outputs | jq -r '.[] | .name + " " + (.scale|tostring)')

# Set the scale of all outputs to 1
swaymsg output "*" scale 1

# Run the game
bwrap --unsetenv \
    --unshare-all \
    --share-net \
    --die-with-parent \
    --proc /proc \
    --dev /dev \
    --tmpfs /tmp \
    --dev-bind /dev /dev \
    --ro-bind /sys /sys \
    --ro-bind /var /var \
    --ro-bind /run /run \
    --ro-bind /etc /etc \
    --ro-bind /usr/share /usr/share \
    --ro-bind /usr/bin /usr/bin \
    --ro-bind /usr/lib /usr/lib \
    --symlink /usr/bin /bin \
    --symlink /usr/lib /lib \
    --symlink /usr/lib /lib64 \
    --symlink /usr/bin /sbin \
    --bind ~/.wine ~/.wine \
    wine64 %GAMEPATH.exe%

# Restore the original scale of all outputs
restore_scale
