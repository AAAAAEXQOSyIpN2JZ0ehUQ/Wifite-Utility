#!/bin/bash

cd /opt
sudo rm -rf Wifite-Utility
sudo git clone https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility.git
sudo chmod +x Wifite-Utility/*
sudo chmod +x Wifite-Utility/Install/*
cd Wifite-Utility
ls -ltha
cd
echo "cd /opt/Wifite-Utility && sudo ./Wifite-Utility.sh" > wifiteutility
sudo chmod +x wifiteutility
sudo mv wifiteutility /usr/local/bin/
cd
sudo apt-get -y update
sudo apt-get install -y wifite
sudo apt install -y hcxdumptool hcxtools
sudo wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility/refs/heads/main/Install/crear_guiwifite_desktop.sh -O - | sudo bash && sudo rm -rf wget-log*
