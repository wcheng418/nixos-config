#!/bin/sh
bwrap --unsetenv \
  --unshare-all \
  --die-with-parent \
  --proc /proc/ \
  --dev /dev/ \
  --dev-bind /dev/nvidia0 /dev/nvidia0 \
  --dev-bind /dev/nvidia-uvm /dev/nvidia-uvm \
  --dev-bind /dev/nvidia-caps/ /dev/nvidia-caps/ \
  --dev-bind /dev/nvidia-uvm-tools /dev/nvidia-uvm-tools \
  --dev-bind /dev/nvidiactl /dev/nvidiactl \
  --ro-bind /usr/ /usr/  \
  --ro-bind /bin/ /bin/ \
  --ro-bind /sys/ /sys/ \
  --ro-bind /lib64/ /lib64/ \
  --ro-bind /var/ /var/ \
  --ro-bind /etc/ld.so.cache /etc/ld.so.cache \
  --ro-bind /etc/ld.so.conf /etc/ld.so.conf \
  --ro-bind /etc/ld.so.conf.d/ /etc/ld.so.conf.d/ \
  --ro-bind /opt/cuda/ /opt/cuda/ \
  --bind ~/Projects/llama.cpp/ ~/Projects/llama.cpp/ \
  ./main $@
