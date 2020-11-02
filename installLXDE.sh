#!/bin/bash
# Install LXDE (Lightweight Desktop Environment) on a NVIDIA Jetson Developer Kit
# Install the LightDM desktop manager
# Use Compton desktop compositor 
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install lightdm -y
sudo apt-get install lxde compton -y

# Write the following text to the file /etc/xdg/autostart/lxde-compton.desktop
# This tells LXDE to use the Compton compositor
sudo dd of=/etc/xdg/autostart/lxde-compton.desktop << EOF
[Desktop Entry]
Type=Application
Name=Compton (X Compositor)
GenericName=X compositor
Comment=A X compositor
TryExec=compton
Exec=compton --backend glx -b
OnlyShowIn=LXDE
EOF

# Use the lightdm desktop manager instead of gdm3
# lxde works with either lightdm or gdm3; If you want to use only gdm3, comment this line out
sudo debconf-set-selections <<< "lightdm shared/default-x-display-manager select lightdm"

# You can manually change desktop managers using:
# sudo dpkg-reconfigure lightdm
#

# Also, put a LXTerminal shortcut on the desktop
cp lxterminal.desktop ~/Desktop/lxterminal.desktop

echo
echo
echo 'In order to use LXDE, you will need to logout.'
echo 'Before you login back in, select "LXDE" from the settings menu in the login screen'
echo 'After logging in, you will need to reboot for the LightDM changes to take effect.'

