#!/bin/bash

# Exit script if return code != 0
set -e

aur_start() {
    # Install packages that all PKGBUILDs automatically assume are installed
    pacman -S --needed --noconfirm base-devel
    # Create makepkg-user" user for building packages, as we can't and shouldn't
    # build packages as root (although we're effectively root all the time when
    # interacting with docker, so it's a bit of a moot point...)
    useradd -m -s /bin/bash makepkg-user
    echo -e "makepkg-password\nmakepkg-password" | passwd makepkg-user
    #echo "makepkg-user ALL=(ALL)
}

aur_finish() {
    # Remove "makepkg-user" - we don't want unnecessary users lying around in the image
    userdel -r makepkg-user
    # Remove base-devel packages, except a few useful core packages
    pacman -Ru --noconfirm $(pacman -Qgq base-devel | grep -v pacman | grep -v sed | grep -v grep | grep -v gzip)
}

aur_build() {
    local pkg=$1

    # Download and extract package files from AUR
    local tar_path="/tmp/${pkg}.tar.gz"
    curl -s -L -o ${tar_path} "https://aur.archlinux.org/cgit/aur.git/snapshot/${pkg}.tar.gz"
    tar xvf ${tar_path} -C /tmp
    chmod a+rwx /tmp/${pkg}

    # Build and install package
    su -c "cd /tmp/${pkg} && makepkg" - makepkg-user
    pacman -U "/tmp/${pkg}/${pkg}-*-x86_64.pkg.tar.xs" --noconfirm
}

#tar_path="/tmp/teamspeak3-server.tar.gz"
#curl -L -o ${tar_path} "https://aur.archlinux.org/cgit/aur.git/snapshot/teamspeak3-server.tar.gz"
#tar xvf ${tar_path} -C /tmp

# create "makepkg-user" user for makepkg
#useradd -m -s /bin/bash makepkg-user
#echo -e "makepkg-password\nmakepkg-password" | passwd makepkg-user
#echo "makepkg-user ALL=(ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)

#su -c 'cd /tmp/teamspeak3-server && makepkg' - makepkg-user
#pacman -U "/tmp/teamspeak3-server/teamspeak3-server-*-x86_64.pkg.tar.xz" --noconfirm
