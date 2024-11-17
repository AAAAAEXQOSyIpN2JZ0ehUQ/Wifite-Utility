#!/bin/bash

# Comprobación de permisos de root
if [[ $EUID -ne 0 ]]; then
  echo -e "\n\033[33m[\033[31mError\033[33m]\033[0m - Necesitas ejecutar este script como root."
  echo -e "\n\033[32m sudo $0 \033[0m"
  exit 1
fi

echo -e "\033[36m[INFO]\033[0m Instalando dependencias necesarias para Pyrit..."
# Instalación de librerías necesarias
apt update
apt install -y python3 python3-pip build-essential libssl-dev libpcap-dev libffi-dev

# Descarga y preparación de Pyrit
echo -e "\033[36m[INFO]\033[0m Descargando Pyrit..."
cd /opt
rm -rf Pyrit
git clone https://github.com/JPaulMora/Pyrit.git
chmod +x Pyrit/*
cd Pyrit

echo -e "\033[36m[INFO]\033[0m Compilando e instalando Pyrit..."
python3 setup.py clean
python3 setup.py build
python3 setup.py install

# Mover el binario a /usr/local/bin para facilitar el acceso
echo -e "\033[36m[INFO]\033[0m Configurando Pyrit en /usr/local/bin..."
cp pyrit /usr/local/bin/

# Verificar instalación
if command -v pyrit &>/dev/null; then
  echo -e "\033[32m[OK]\033[0m Pyrit instalado correctamente. Verificando instalación..."
  pyrit -h
else
  echo -e "\033[31m[ERROR]\033[0m Pyrit no se instaló correctamente. Verifica los pasos anteriores."
  exit 1
fi

echo -e "\033[36m[INFO]\033[0m Instalación completa. Puedes usar Pyrit escribiendo: \033[32mpyrit\033[0m en la terminal."
echo -e "\nPresiona \033[32mEnter\033[0m para cerrar esta ventana..."
read -r

