
#!/bin/bash

set -e

echo "Running git clone on sddm github..."
sudo git clone -b master --depth 1 https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme

# Check if the clone was successful
if [ $? -eq 0 ]; then
  cd /usr/share/sddm/themes/sddm-astronaut-theme
else
  echo "Failed to clone the repository."
  exit 1
fi

echo "Copying fonts over..."
sudo cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/

echo "Editing SDDM conf..."
echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf

echo "Editing vitrualkbd..."
echo "[General]
InputMethod=qtvirtualkeyboard" | sudo tee /etc/sddm.conf.d/virtualkbd.conf

echo "Done."

exit 0


