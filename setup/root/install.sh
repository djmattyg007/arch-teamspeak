#!/bin/bash

# Exit script if return code != 0
set -e

source /root/functions.sh

# Install any packages
aur_start
aur_build teamspeak3-server
aur_finish

mkdir /teamspeak

# Cleanup
pacman_cleanup
