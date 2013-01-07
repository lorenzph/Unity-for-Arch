#!/bin/bash

# Do not run this manually

get_ubuntu_version() {
  if [ -z "${1}" ]; then
    echo "No package was provided"
    exit 1
  fi
  if [ -z "${2}" ]; then
    echo "No Ubuntu version was provided"
    exit 1
  fi
  wget -q -O - "https://launchpad.net/ubuntu/${2}/+source/${1}" | \
    sed -n 's/^.*current\ release\ (\(.*\)-\(.*\)).*$/\1 \2/p'
}

get_launchpad_version() {
  if [ -z "${1}" ]; then
    echo "No package was provided"
    exit 1
  fi
  local PACKAGE=${1}
  local TARBALL=${1}
  if [ ! -z "${2}" ]; then
    TARBALL=${2}
  fi
  wget -q -O - "https://launchpad.net/${PACKAGE}/+download" | \
    sed -n "s/.*${TARBALL}-\(.*\)\.tar.*/\1/p" | head -n 1
}

get_pypi_version() {
  if [ -z "${1}" ]; then
    echo "No package was provided"
    exit 1
  fi
  wget -q -O - "http://pypi.python.org/pypi/${1}" | \
    sed -n "s/.*>${1}-\(.*\)\.tar.*<.*/\1/p" | head -n 1
}

get_gnome_version() {
  if [ -z "${1}" ]; then
    echo "No package was provided"
    exit 1
  fi
  if [ -z "${2}" ]; then
    echo "No major version was provided"
    exit 1
  fi
  wget -q -O - "http://ftp.gnome.org/pub/GNOME/sources/${1}/${2}/" | \
    sed -n 's/.*>LATEST-IS-\(.*\)<.*/\1/p'
}

get_archlinux_version() {
  if [ -z "${1}" ]; then
    echo "No package was provided"
    exit 1
  fi
  if [ -z "${2}" ]; then
    echo "No repository was provided"
    exit 1
  fi
  if [ -z "${3}" ]; then
    echo "No architecture was provided"
    exit 1
  fi
  wget -q -O - "https://www.archlinux.org/packages/${2}/${3}/${1}/" | \
    sed -n "/<title>/ s/^.*${1}\ \(.*\)-\(.*\)\ (.*$/\1 \2/p"
}

get_xorg_version() {
  if [ -z "${1}" ]; then
    echo "No package was provided"
    exit 1
  fi
  if [ -z "${2}" ]; then
    echo "No category was provided"
    exit 1
  fi
  wget -q -O - "http://xorg.freedesktop.org/releases/individual/${2}/" |
    sed -n "s/.*${1}-\(.*\)\.tar.*/\1/p" | tail -n 1
}
