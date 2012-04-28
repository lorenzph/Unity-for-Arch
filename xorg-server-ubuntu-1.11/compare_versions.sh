#!/usr/bin/env bash

source "$(dirname ${0})/PKGBUILD"

echo "Getting latest Ubuntu version..."
UBUNTU_VER=($(wget -q 'http://packages.ubuntu.com/precise/source/xorg-server' -O - | sed -n 's/.*>xorg-server_\(.*\)-\(.*\)\.diff\.gz<.*/\1 \2/p'))

echo "Getting latest Arch Linux version..."
ARCHLINUX_VER=($(wget -q 'https://www.archlinux.org/packages/extra/x86_64/xorg-server/' -O - | sed -n '/<title>/ s/^.*xorg-server\ \(.*\)-\(.*\)\ (.*$/\1 \2/p'))

echo "Getting latest upstream version..."
UPSTREAM_VER=$(wget -q http://xorg.freedesktop.org/releases/individual/xserver/ -O - | sed -n 's/.*xorg-server-\(.*\).tar.bz2.*/\1/p' | tail -n 1)

echo ""

echo -e "PKGBUILD version:   ${_actual_ver} ${_ubuntu_rel}"
echo -e "Upstream version:   ${UPSTREAM_VER}"
echo -e "Arch Linux version: ${ARCHLINUX_VER[@]}"
echo -e "Ubuntu version:     ${UBUNTU_VER[@]}"
