#!/bin/bash

set -e

if ! yay -Q papirus-icon-theme &>/dev/null || ! yay -Q papirus-folders &>/dev/null; then
  echo "papirus packages not installed."
  exit 1
fi

REPO_URL="https://github.com/vinceliuice/Graphite-gtk-theme.git"
REPO_NAME="Graphite-gtk-theme"

cd ~

# Check if the repository already exists
if [ -d "$REPO_NAME" ]; then
  echo "Repository '$REPO_NAME' already exists. Skipping clone"
else
  git clone "$REPO_URL" --depth=1
fi

# Check if the clone was successful
if [ $? -eq 0 ]; then
  cd "$REPO_NAME"
else
  echo "Failed to clone the repository."
  exit 1
fi

echo "Running GTK install script"
./install.sh -c dark -s standard -s compact -l --tweaks black rimless

echo "Papirus folders to black"
papirus-folders -C black

echo "Done. Please run nwg-look to update theme."

exit 0


