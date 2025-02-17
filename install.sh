#!/bin/bash

## :computer: Instalación
cd /opt
sudo cp -r Wifite-Utility/hs /opt/hs_backup
sudo cp Wifite-Utility/cracked.json /opt/cracked.json_backup
sudo rm -rf Wifite-Utility
sudo git clone https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility.git
sudo cp -r /opt/hs_backup /opt/Wifite-Utility/hs
sudo cp /opt/cracked.json_backup /opt/Wifite-Utility/cracked.json
sudo chmod +x Wifite-Utility/*
sudo chmod +x Wifite-Utility/Install/* 
cd Wifite-Utility
ls -ltha

## :key: Acceso Directo
cd
echo "cd /opt/Wifite-Utility && sudo ./Wifite-Utility.sh" > gwifite
echo "cd /opt/Wifite-Utility && sudo ./Wifite-Utility.sh" > xwifite
sudo chmod +x gwifite xwifite
sudo mv gwifite xwifite /usr/local/bin/
cd

## :package: Paquete
sudo apt-get -y update
sudo apt-get install -y wifite
sudo apt install -y hcxdumptool hcxtools

## :computer: Crear Desktop
sudo wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility/refs/heads/main/Install/crear_guiwifite_desktop.sh -O - | sudo bash && sudo rm -rf wget-log*

# Fin del script
