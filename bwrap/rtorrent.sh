#!/bin/sh

bwrap --unsetenv \
    --unshare-all \
    --share-net \
    --die-with-parent \
    --proc /proc \
    --dev /dev \
    --ro-bind /run /run \
    --ro-bind /etc /etc \
    --ro-bind /usr/share /usr/share \
    --ro-bind /usr/bin /usr/bin \
    --ro-bind /usr/lib /usr/lib \
    --symlink /usr/bin /bin \
    --symlink /usr/lib /lib \
    --symlink /usr/lib /lib64 \
    --symlink /usr/bin /sbin \
    --ro-bind ~/.rtorrent.rc ~/.rtorrent.rc \
    --bind ~/.config/.rtorrent.session ~/.config/.rtorrent.session \
    --bind ~/Downloads/Torrents ~/Downloads/Torrents \
    rtorrent $@
