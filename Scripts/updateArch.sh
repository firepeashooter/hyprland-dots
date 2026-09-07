#!/bin/bash
set -e #Script immediatley fails if the system update fails

echo "[1/3] Starting System Update... "
sudo pacman -Syu
echo "Main Packages Updated"

echo "[2/3] Removing Uninstalled Packages..."
sudo paccache -rk1
echo "Uninstalled Packages Removed"

echo "[3/3] Checking for orphaned packages..."
orphans=$(pacman -Qtdq || true)

if [ -n "$orphans" ]; then
	echo "Found orphans, removing..."
	sudo pacman -Rns $(pacman -Qtdq)
	echo "Orphaned packages removed."
else
	echo "No orphaned packages found."
fi

echo "System update and cleanup complete!"
