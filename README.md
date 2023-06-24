# arch-fw-installer.sh
Shell Script to automatically install possibly missing firmware for modules used to create an initial ramdisk

Source list of modules and its corresponding package is available on [archwiki#mkinitcpio](https://wiki.archlinux.org/title/mkinitcpio#Possibly_missing_firmware_for_module_XXXX) article.


## Usage
This script contains variables that should be check and rewrite (lines 17-22) to be properly used in target environemnt and used [AUR helper](https://wiki.archlinux.org/title/AUR_helpers):

Example for [yay](https://aur.archlinux.org/packages/yay):
```bash
function syncCommand() {
  sudo pacman -Sy && yay
}
downloadCommand="yay"
downloadAurCommand="yay --aur"
```


Default vars are declared for [paru](https://aur.archlinux.org/packages/paru):
```bash
function syncCommand() {
  sudo pacman -Sy && sudo powerpill -Su && paru
}

downloadCommand="paru"
downloadAurCommand="paru"
```

## Oneliners to run from internet
(downloads with `wget` or `curl` to `/tmp`)
### using wget with SSL
```bash
wget 'https://raw.githubusercontent.com/emilwojcik93/arch-fw-installer/main/arch-fw-installer.sh' -O "/tmp/arch-fw-installer.sh" && chmod 755 "/tmp/arch-fw-installer.sh" && sudo /tmp/arch-fw-installer.sh
```
### using wget WITHOUT SSL
```bash
wget --no-check-certificate 'https://raw.githubusercontent.com/emilwojcik93/arch-fw-installer/main/arch-fw-installer.sh' -O "/tmp/arch-fw-installer.sh" && chmod 755 "/tmp/arch-fw-installer.sh" && sudo /tmp/arch-fw-installer.sh
```
### using curl with SSL
```bash
curl --proto '=https' --tlsv1.2 -sSfL 'https://raw.githubusercontent.com/emilwojcik93/arch-fw-installer/main/arch-fw-installer.sh' -o "/tmp/arch-fw-installer.sh" && chmod 755 "/tmp/arch-fw-installer.sh" && sudo /tmp/arch-fw-installer.sh
```
### using curl WITHOUT SSL
```bash
curl -k -L 'https://raw.githubusercontent.com/emilwojcik93/arch-fw-installer/main/arch-fw-installer.sh' -o "/tmp/arch-fw-installer.sh" && chmod 755 "/tmp/arch-fw-installer.sh" && sudo /tmp/arch-fw-installer.sh
```
### Execute using `git`

Clone it in current directory and execute `arch-fw-installer.sh`
```bash
git clone git@github.com:emilwojcik93/arch-fw-installer.git
cd arch-fw-installer
sudo ./arch-fw-installer.sh
```


Relevant links:
 - https://wiki.archlinux.org/title/mkinitcpio
 - https://wiki.archlinux.org/title/AUR_helpers
 - https://aur.chaotic.cx/