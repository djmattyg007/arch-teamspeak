#!/bin/bash

# Exit script if return code != 0
set -e

# Install any packages
source /root/aur.sh
aur_start
aur_build teamspeak3-server
aur_finish

mkdir /data

# Cleanup
source /root/pacman-cleanup.sh
