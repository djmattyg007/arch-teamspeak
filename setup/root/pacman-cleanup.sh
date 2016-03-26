#!/bin/bash

# Exit script if return code != 0
set -e

yes | pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /tmp/*
