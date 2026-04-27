#!/bin/bash
qemu-system-x86_64 \
  -enable-kvm \
  -cpu host \
  -m 2G \
  -smp 2 \
  -drive file=debian-server.qcow2,if=virtio \
  -netdev user,id=net0,hostfwd=tcp::2222-:22 \
  -device virtio-net-pci,netdev=net0 \
  -display none # Solo uso pantalla para la instalación, luego solo me conecto por ssh desde mi maquina host.
  -daemonize #Lanza el servidor en segundo plano
