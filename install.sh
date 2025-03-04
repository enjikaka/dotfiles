#!/usr/bin/env bash

git pull origin main

echo -e "\nInstalling fonts..."
source install-fonts.sh

stow .
