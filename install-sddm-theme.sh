
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

# TODO: check if dir exists
echo "Copy over background image..."
sudo cp ~/dotfiles/backgrounds/fern.jpg /usr/share/sddm/themes/sddm-astronaut-theme/Backgrounds/

echo "Copy theme..."
sudo cp /usr/share/sddm/theme/sddm-astronaut-theme/Themes/astronaut.conf /usr/share/sddm/theme/sddm-astronaut-theme/Themes/fern.conf 

echo "Replace image in new theme..."
sudo sed -i 's|Background="[^"]*"|Background="Backgrounds/fern.jpg"|' /usr/share/sddm/theme/sddm-astronaut-theme/Themes/fern.conf 

echo "Set new theme as default..."
sudo sed -i 's|ConfigFile=Themes/[^ ]*|ConfigFile=Themes/fern.conf|' /usr/share/sddm/theme/sddm-astronaut-theme/metadata.desktop

echo "Done."

exit 0


