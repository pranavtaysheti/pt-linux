#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# rpm-ostree install screen

# this would install a package from rpmfusion
# rpm-ostree install vlc
rpm-ostree install conky

#### Example for enabling a System Unit File

# systemctl enable podman.socket

# Install Nerd Fonts

FONT_DIR="/usr/share/fonts/"
NERD_FONTS=("JetBrainsMono")

for font in ${NERD_FONTS[@]};
do
    mkdir -p "$FONT_DIR/$font-NF"
    curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font.tar.xz
    tar -xJf JetBrainsMono.tar.xz -C "$FONT_DIR/$font-NF"
done

# Network configuration

rpm-ostree install iwd dhcpcd

ETC_DIR="/usr/etc/NetworkManager/conf.d"
mkdir -p "$ETC_DIR"

echo "[main]
dhcp=dhcpcd" > "$ETC_DIR/dhcp-client.conf"

echo "[device]
wifi.backend=iwd" > "$ETC_DIR/wifi-backend.conf"

# Kernel parameter configuration

# rpm-ostree kargs --append="intel_iommu=on" #doesn't work for some reason

