#!/bin/bash

cd /opt
sudo rm -rf Wifite-Utility
sudo git clone https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility.git
sudo chmod +x Wifite-Utility/*
cd Wifite-Utility
ls -ltha
cd
echo "cd /opt/Wifite-Utility && sudo ./Wifite-Utility.sh" > wifiteutility
sudo chmod +x wifiteutility
sudo mv wifiteutility /usr/local/bin/
cd
