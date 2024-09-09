#!/bin/bash

# Lista de paquetes para instalar
packages_list=(
    aircrack-ng aireplay-ng airmon-ng airodump-ng awk curl hostapd iwconfig lighttpd
    macchanger mdk3 unzip xterm openssl rfkill strings fuser
)

# Función para verificar e instalar paquetes
function pkgscheck_flux() {
    echo -e "\n\033[1m\033[34m--- Verificando e Instalando Paquetes de Fluxion ---\033[0m"
    for pkg in "${packages_list[@]}"; do
        echo -e "\033[1m\033[34m[\033[31m+\033[34m] \033[0mVerificando $pkg\033[0m"
        if ! command -v $pkg &> /dev/null; then
            echo -e "\033[1m\033[31mNo Encontrado\033[0m"
            echo -e "\033[1m\033[31mInstalando \033[0m$pkg"
            apt-get install -y $pkg
        else
            echo -e "\033[1m\033[32mEncontrado\033[0m"
        fi
    done

    echo -e "\n\033[1m\033[34m[\033[31m+\033[34m] \033[0mVerificando dhcpd\033[0m"
    if ! command -v dhcpd &> /dev/null; then
        echo -e "\033[1m\033[31mNo Encontrado\033[0m"
        echo -e "\033[1m\033[31mInstalando \033[0mdhcpd"
        apt-get install -y isc-dhcp-server
    else
        echo -e "\033[1m\033[32mEncontrado\033[0m"
    fi
}

# Verificar permisos de usuario
if [ "$(whoami)" != "root" ]; then
    echo -e "\033[1m\033[31m¡Por favor, ejecute este script como root!\033[0m"
    echo -e "\033[1m\033[31mIntente usar sudo bash install.sh\033[0m"
    exit 1
fi

# Verificar y añadir fuente en sources.list
source="deb http://ftp.debian.org/debian/ stretch main contrib non-free"
path="/etc/apt/sources.list"

echo -e "\n\033[1m\033[34m--- Verificando Fuente en sources.list ---\033[0m"
if ! grep -qF "$source" "$path"; then
    echo -e "\033[1m\033[31mNo Encontrado\033[0m"
    echo "Añadiendo $source a $path"
    echo "$source" >> "$path"
else
    echo -e "\033[1m\033[32mEncontrado\033[0m"
fi

# Verificar e instalar dependencias
echo -e "\n\033[1m\033[34m--- Verificando e Instalando Dependencias ---\033[0m"
dependencies=(
    "/usr/bin/git" "/usr/bin/python" "/usr/bin/python2" "/usr/bin/python2 -m pip"
    "/usr/bin/nmap" "/usr/bin/php-cgi"
)

for dep in "${dependencies[@]}"; do
    dep_name=$(basename $dep)
    echo -e "\033[1m\033[34m[\033[31m+\033[34m] \033[0mVerificando $dep_name\033[0m"
    if [ -x "$dep" ]; then
        echo -e "\033[1m\033[32mEncontrado\033[0m"
    else
        case "$dep" in
            "/usr/bin/git")
                echo -e "\033[1m\033[31mNo Encontrado\033[0m"
                echo -e "\033[1m\033[31mInstalando \033[0mgit"
                apt-get install -y git
                ;;
            "/usr/bin/python")
                echo -e "\033[1m\033[31mNo Encontrado\033[0m"
                echo -e "\033[1m\033[31mInstalando \033[0mpython2"
                apt-get install -y python2
                ;;
            "/usr/bin/python2 -m pip")
                echo -e "\033[1m\033[31mNo Encontrado\033[0m"
                echo -e "\033[1m\033[31mInstalando \033[0mpython2-pip"
                curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
                python2 get-pip.py
                ;;
            "/usr/bin/nmap")
                echo -e "\033[1m\033[31mNo Encontrado\033[0m"
                echo -e "\033[1m\033[31mInstalando \033[0mnmap"
                apt-get install -y nmap
                ;;
            "/usr/bin/php-cgi")
                echo -e "\033[1m\033[31mNo Encontrado\033[0m"
                echo -e "\033[1m\033[31mInstalando \033[0mphps-cgi"
                apt-get install -y php-cgi
                ;;
        esac
    fi
done

# Instalar dependencias de Fluxion
pkgscheck_flux

# Actualizar y actualizar el sistema
echo -e "\n\033[1m\033[34m--- Actualizando y Mejorando el Sistema ---\033[0m"
apt-get update -y && apt-get upgrade -y

# Reinstalar python2 y dependencias adicionales
echo -e "\n\033[1m\033[34m--- Reinstalando y Configurando Dependencias ---\033[0m"
apt-get install -y python2 python2.7-dev libssl-dev zlib1g-dev libpcap-dev libpq-dev

# Eliminar pyrit
echo -e "\n\033[1m\033[34m--- Eliminando pyrit ---\033[0m"
apt-get remove --purge -y pyrit && rm -rf /usr/local/lib/python2.7/dist-packages/cpyrit/

# Instalar paquetes adicionales
echo -e "\n\033[1m\033[34m--- Instalando Paquetes Adicionales ---\033[0m"
pip install setuptools psycopg2 scapy
apt-get install -y python-scapy

# Descargar e instalar Pyrit
echo -e "\n\033[1m\033[34m--- Descargando e Instalando Pyrit ---\033[0m"
if [ ! -d Pyrit ]; then
    git clone https://github.com/JPaulMora/Pyrit
fi

sed -i "s/COMPILE_AESNI/COMPILE_AESNIX/" Pyrit/cpyrit/_cpyrit_cpu.c
cd Pyrit && python2 setup.py clean && python2 setup.py build && python2 setup.py install

echo -e "\n\033[1m\033[32mInstalación Completada\033[0m"
