#!/usr/bin/env bash

#Color for print
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# yay example
#function syncCommand() {
#  sudo pacman -Sy && yay
#}
#downloadCommand="yay"
#downloadAurCommand="yay --aur"

file="/tmp/mkinitcpio.out"

function syncCommand() {
  sudo pacman -Sy && sudo powerpill -Su && paru
}

downloadCommand="paru"
downloadAurCommand="paru"

function findStringFn() {
  if grep -q "${1}" ${2}; then
    return 0
  else
    return 1
  fi
}

function installFirmwareFn() {
  local comm="${1}"
  local module="${2}"
  local package="${3}"
  if findStringFn "==> WARNING: Possibly missing firmware for module: ${module}" ${file}; then
    if pacman -Qs ${package} > /dev/null ; then
      echo -e "Firmware: ${GREEN}\"${package}\"${NC}, for module: ${RED}${module}${NC}, is already installed"
    else
      ${comm} "${package}"
      echo -e "Installation complete of firmware ${GREEN}\"${package}\"${NC}, for module: ${RED}${module}${NC}"
    fi
  else
    echo -e "Firmware: ${GREEN}\"${package}\"${NC}, for module: ${RED}${module}${NC}, is installed or not needed on this configuration"
  fi
}

function rewriteConfigFn() {

  # aic94xx (AUR)
  installFirmwareFn ${downloadAurCommand} "'aic94xx'" "aic94xx-firmware"

  # ast (AUR)
  installFirmwareFn ${downloadAurCommand} "'ast'" "ast-firmware"

  # wd719x (AUR)
  installFirmwareFn ${downloadAurCommand} "'wd719x'" "wd719x-firmware"

  # xhci_pci (AUR)
  installFirmwareFn ${downloadAurCommand} "'xhci_pci'" "upd72020x-fw"

  # bfa
  installFirmwareFn ${downloadCommand} "'bfa'" "linux-firmware-qlogic"

  # bnx2x
  installFirmwareFn ${downloadCommand} "'bnx2x'" "linux-firmware-bnx2x"

  # liquidio
  installFirmwareFn ${downloadCommand} "'liquidio'" "linux-firmware-liquidio"

  # mlxsw_spectrum
  installFirmwareFn ${downloadCommand} "'mlxsw_spectrum'" "linux-firmware-mellanox"

  # nfp
  installFirmwareFn ${downloadCommand} "'nfp'" "linux-firmware-nfp"

  # qed
  installFirmwareFn ${downloadCommand} "'qed'" "linux-firmware-qlogic"

  # qla1280
  installFirmwareFn ${downloadCommand} "'qla1280'" "linux-firmware-qlogic"

  # qla2xxx
  installFirmwareFn ${downloadCommand} "'qla2xxx'" "linux-firmware-qlogic"

}

if [ ! -f ${file} ]
then
    sudo mkinitcpio -P &> ${file}
else
    echo "File: ${file} found."
fi

syncCommand && \
rewriteConfigFn && \
sudo rm -f ${file} && \
sudo mkinitcpio -P
