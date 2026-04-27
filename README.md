# Server-Samba-Linux

Este proyecto consiste en el despliegue y securización de un servidor de archivos **Samba** sobre **Debian**. El objetivo principal es simular un entorno real de servidores Linux para aprender sobre administración, redes y endurecimiento de sistemas (*hardening*).

## 🚀 Hoja de Ruta (Roadmap)
- [x] Despliegue inicial en VM con QEMU/KVM (Red NAT).
- [ ] Configuración de red puente (Bridge) para acceso desde la red local física.
- [ ] Implementación de políticas de Hardening y auditoría.

## 🛠️ Tecnologías Utilizadas
* **Virtualización:** QEMU/KVM
* **S.O:** Debian 13
* **Servicios:** Samba
* **Seguridad:** AppArmor, UFW / iptables
* **Automatización:** Bash scripting

## 🏗️ Arquitectura
Actualmente, el servidor opera en una **VM bajo NAT**, permitiendo la comunicación host-guest. El siguiente paso es la transición a una infraestructura de red puente para escalabilidad.

---
> [!NOTE]
> Este proyecto está en desarrollo constante a medida que incorporo nuevos conceptos de administración de sistemas.
