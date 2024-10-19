#!/bin/bash
#====================================================
#   SCRIPT:                   Wifite Utility
#   DESARROLLADO POR:         Jony Rivera (Dzhoni)
#   FECHA DE ACTUALIZACIÓN:   08-09-2024 
#   CONTACTO POR TELEGRAMA:   https://t.me/Dzhoni_dev
#   GITHUB OFICIAL:           https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility
#====================================================
x="ok"

# Paleta de colores
reset="\033[0m"       # Restablecer todos los estilos y colores
bold="\033[1m"        # Texto en negrita
italic="\033[3m"      # Texto en cursiva
underline="\033[4m"   # Texto subrayado
blink="\033[5m"       # Texto parpadeante
reverse="\033[7m"     # Invertir colores de fondo y texto
hidden="\033[8m"      # Texto oculto (generalmente invisible)

# Colores de texto
black="\033[0;30m"     # Negro
red="\033[0;31m"       # Rojo
green="\033[0;32m"     # Verde
yellow="\033[0;33m"    # Amarillo
blue="\033[0;34m"      # Azul
magenta="\033[0;35m"   # Magenta
cyan="\033[0;36m"      # Cian
white="\033[0;37m"     # Blanco

# Colores de fondo
bg_black="\033[0;40m"     # Fondo Negro
bg_red="\033[0;41m"       # Fondo Rojo
bg_green="\033[0;42m"     # Fondo Verde
bg_yellow="\033[0;43m"    # Fondo Amarillo
bg_blue="\033[0;44m"      # Fondo Azul
bg_magenta="\033[0;45m"   # Fondo Magenta
bg_cyan="\033[0;46m"      # Fondo Cian
bg_white="\033[0;47m"     # Fondo Blanco

# Iconos v3
checkmark="${white}[${green}+${white}]${green}"
error="${white}[${red}-${white}]${red}"
info="${white}[${yellow}*${white}]${yellow}"
unknown="${white}[${blue}!${white}]${blue}"
process="${white}[${magenta}>>${white}]${magenta}"
indicator="${red}==>${cyan}"

# Barra de separación
barra="${blue}|--------------------------------------------|${reset}"
bar="${yellow}----------------------------------------------${reset}"

# Comprobación de permisos de root
[[ "$(whoami)" != "root" ]] && {
    echo -e "\n${yellow}[${red}Error${yellow}] ${white}- ${yellow}Necesitas ejecutar esto como administrador (${red}root${yellow})${reset}"
    echo -e "\n${green} sudo $0 ${reset}"
    exit 0
}

# menú de interfaz de usuario
user_interface_menu() {

fun_banner() {
  # Mostrar segundo banner
  clear
  echo -e "\n${green}   .               .    "
  echo -e " ${green}.´  ·  .     .  ·  \`.   ${green}wifite2 2.7.0${reset}"
  echo -e " ${green}:  :  :  ${white}(¯)${green}  :  :  :   ${white}a wireless auditor by derv82${reset}"
  echo -e " ${green}\`·  ·  \`${white} /¯\\ ${green}·  ·  \`·   ${white}maintained by kimocoder${reset}"
  echo -e " ${green}  \`     ${white}/¯¯¯\\    ${green} \`     ${cyan}https://github.com/kimocoder/wifite2${reset}"
  echo -e " \n${green}GUI Version codificada por: Jony Rivera (Dzhoni) ${reset}"
}

# Función de actualización
P_SERVER="https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility/main/Install/"
v1=$(curl -sSL "${P_SERVER}/versionact")
v2=$(cat /opt/Wifite-Utility/Install/versionact)

txt01="Tu versión está actualizada"
txt02="¡Hay una actualización disponible!"

# Compara las versiones y define el mensaje
if [[ $v1 = $v2 ]]; then
    versionSCT="${green}${txt01} ${cyan}$v2${reset}"
else
    versionSCT="${red}${txt02} ${cyan}$v1${reset}"
fi

# Función para crear el diccionario
crear_diccionario() {
    # Ruta del archivo de salida donde se almacenará el diccionario final
    local output_file="/usr/share/wordlists/defaultWordList.txt"

    # Verificar si el diccionario ya existe para evitar sobrescribirlo
    if [[ ! -f "$output_file" ]]; then
        echo -e "\n${info} Creando diccionario.....${reset}\n"

        # Descomprimir el archivo rockyou.txt.gz si aún no ha sido descomprimido
        sudo apt install -y wordlists
        if [[ ! -f "/usr/share/wordlists/rockyou.txt" ]]; then
            sudo gzip -d /usr/share/wordlists/rockyou.txt.gz
        fi

        # Combinar varias listas de palabras en un solo archivo temporal
        cat /usr/share/set/src/fasttrack/wordlist.txt \
            /usr/share/john/password.lst \
            /usr/share/nmap/nselib/data/passwords.lst \
            /usr/share/wordlists/rockyou.txt \
            /usr/share/sqlmap/data/txt/wordlist.txt \
            /usr/share/dict/wordlist-probable.txt > diccionario_combinado.txt

        # Ordenar las palabras en el archivo combinado y eliminar duplicados
        sort diccionario_combinado.txt | uniq > diccionario_sin_duplicados.txt

        # Filtrar las palabras con 8 caracteres o más y guardarlas en el archivo final
        grep -E '\b\w{8,}\b' diccionario_sin_duplicados.txt > "$output_file"

        # Asignar permisos de ejecución al diccionario final (aunque no es estrictamente necesario)
        sudo chmod +x "$output_file"
        
        # Eliminar los archivos temporales utilizados en el proceso
        sudo rm -rf diccionario_combinado.txt diccionario_sin_duplicados.txt

        # Contar y mostrar el número total de palabras en el diccionario final
        wc -l "$output_file"

        echo -e "\n${info} Diccionario creado en ${output_file}${reset}\n"
    else
        # Si el diccionario ya existe, se muestra un mensaje de advertencia
        echo -e "\n${error} El archivo ${output_file} ya existe.${reset}\n"
    fi
}

# Función para instalar Wifite y herramientas esenciales
instalar_wifite_y_herramientas() {
    # Preguntar si se desea instalar o actualizar Wifite
    read -p "$(echo -e "\n${green}¿Deseas instalar o actualizar Wifite? (Y/n):${white} ")" instalar_wifite
    if [[ $instalar_wifite =~ ^[Yy]$ ]]; then
        echo -e "\n${info} Instalando Wifite.....${reset}\n"
        sudo apt-get -y update
        sudo apt-get install -y wifite
    else
        echo -e "\n${info} Wifite no será instalado o actualizado.${reset}\n"
    fi

    # Preguntar si se desean instalar las herramientas esenciales
    read -p "$(echo -e "\n${green}¿Deseas instalar o actualizar las herramientas esenciales? (Y/n):${white} ")" instalar_herramientas 
    if [[ $instalar_herramientas =~ ^[Yy]$ ]]; then
        echo -e "\n${info} Instalando Herramientas Esenciales.....${reset}\n"
        # sudo apt install -y git hcxdumptool hcxtools libpcap-dev python2.7-dev libssl-dev zlib1g-dev libpcap-dev
        sudo apt install git hcxdumptool hcxtools python2.7-dev python3-dev python3-pip libssl-dev libpcap-dev zlib1g-dev libsqlite3-dev
        sudo pip3 install scapy numpy

    else
        echo -e "\n${info} Las herramientas esenciales no serán instaladas o actualizadas.${reset}\n"
    fi

    # Preguntar si se desea instalar o actualizar Pyrit
    read -p "$(echo -e "\n${green}¿Deseas instalar o actualizar Pyrit? (Y/n):${white} ")" instalar_pyrit 
    if [[ $instalar_pyrit =~ ^[Yy]$ ]]; then
        echo -e "\n${process} Instalando Pyrit......${reset}\n"
        cd /opt
        sudo rm -rf Pyrit
        sudo git clone https://github.com/JPaulMora/Pyrit.git
        sudo chmod +x Pyrit/*
        cd Pyrit
        sudo python3 setup.py clean
        sudo python3 setup.py build
        sudo python3 setup.py install
        pyrit -h
        cd
    else
        echo -e "\n${info} Pyrit no será instalado o actualizado.${reset}\n"
    fi
}

data_system() {
    # Mostrar la configuración de red usando ifconfig
    echo -e "\n${info} Mostrando información de red con ifconfig...${reset}\n"
    ifconfig

    # Mostrar información sobre interfaces inalámbricas utilizando iwconfig
    echo -e "\n${info} Mostrando información de interfaces inalámbricas con iwconfig...${reset}\n"
    iwconfig

    # Mostrar la lista de dispositivos USB conectados usando lsusb
    echo -e "\n${info} Mostrando dispositivos USB conectados con lsusb...${reset}\n"
    lsusb

    # Mostrar información detallada sobre las capacidades inalámbricas del sistema usando iw list
    echo -e "\n${info} Mostrando capacidades inalámbricas con iw list...${reset}\n"
    iw list | grep -A 10 "Supported interface modes:" | grep "*"
}

# Función para instalar drivers
instalar_drivers() {
    while true; do

      # Mostrar banner
      fun_banner

        echo -e "\n${cyan}Selecciona el driver que deseas instalar:${reset}\n"
        echo -e "${green}1  ${white}Instalar build-essential, dkms y headers${reset}"
        echo -e "${green}2  ${white}Instalar realtek-rtl8188eus-dkms${reset}"
        echo -e "${green}3  ${white}Instalar realtek-rtl8814au-dkms${reset}"
        echo -e "${green}4  ${white}Instalar realtek-rtl8723cs-dkms${reset}"
        echo -e "${green}5  ${white}Instalar realtek-rtl88xxau-dkms${reset}"
        echo -e "${green}6  ${white}Instalar realtek-rtl8188fu-dkms${reset}"
        echo -e "${bar}"
        echo -e "${green}7 $versionSCT${reset}"
        echo -e "${bar}"
        echo -e "${green}0  ${white}Volver al menú principal${reset}"
        echo -e "\n${barra}"
        echo -ne "\n${bold}${yellow} Elige una opción:${white} >> "; read option

        case $option in
            1)
                echo -e "\n${info} Instalando build-essential, dkms y headers del núcleo...${reset}\n"
                sudo apt-get install -y build-essential dkms linux-headers-$(uname -r)
                echo -e "\n${info} Instalación completada.${reset}"
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
                ;;
            2)
                echo -e "\n${info} Instalando realtek-rtl8188eus-dkms...${reset}\n"
                sudo apt install -y realtek-rtl8188eus-dkms
                echo -e "\n${info} Instalación completada.${reset}"
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
                ;;
            3)
                echo -e "\n${info} Instalando realtek-rtl8814au-dkms...${reset}\n"
                sudo apt install -y realtek-rtl8814au-dkms
                echo -e "\n${info} Instalación completada.${reset}"
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
                ;;
            4)
                echo -e "\n${info} Instalando realtek-rtl8723cs-dkms...${reset}\n"
                sudo apt install -y realtek-rtl8723cs-dkms
                echo -e "\n${info} Instalación completada.${reset}"
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
                ;;
            5)
                echo -e "\n${info} Instalando realtek-rtl88xxau-dkms...${reset}\n"
                sudo apt install -y realtek-rtl88xxau-dkms
                echo -e "\n${info} Instalación completada.${reset}"
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
                ;;
            6)
                echo -e "\n${info} Instalando realtek-rtl8188fu-dkms...${reset}\n"
                cd /opt
                sudo rm -rf rtl8188fu
                sudo git clone https://github.com/kelebek333/rtl8188fu
                sudo chmod +x rtl8188fu/*
                sudo dkms add ./rtl8188fu
                sudo dkms build rtl8188fu/1.0
                sudo dkms install rtl8188fu/1.0
                sudo cp ./rtl8188fu/firmware/rtl8188fufw.bin /lib/firmware/rtlwifi/
                cd
                echo -e "\n${info} Instalación completada.${reset}"
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
                ;;
            7)
                echo -e "\n${process} ${cyan}Actualizando Script...${reset}\n"
                sudo wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility/main/install.sh -O - | sudo bash
                sudo rm -rf wget-log*
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
                ;;
            0)
                return
                ;;
            *)
                echo -e "\n${error} ${red}Opción no válida, por favor intente de nuevo.${reset}"
                sleep 1
                ;;
        esac
    done
}

# Función para gestionar servicios y verificar el modo monitor
gestionar_servicios_interferentes() {
    while true; do

        # Mostrar banner
        fun_banner

        echo -e "\n${cyan}Selecciona la opción que deseas realizar:${reset}\n"
        echo -e "${green}1  ${white}Detener servicios que interfieren (NetworkManager y wpa_supplicant)${reset}"
        echo -e "${green}2  ${white}Reactivar servicios detenidos${reset}"
        echo -e "${green}3  ${white}Verificar el estado del modo monitor${reset}"
        echo -e "${bar}"
        echo -e "${green}4 $versionSCT${reset}"
        echo -e "${bar}"
        echo -e "${green}0  ${white}Volver al menú principal${reset}"
        echo -e "\n${barra}"
        echo -ne "\n${bold}${yellow} Elige una opción:${white} >> "; read option

        case $option in
            1)
                echo -e "\n${info} Deteniendo servicios que pueden interferir...${reset}\n"
                sudo systemctl stop NetworkManager
                sudo systemctl stop wpa_supplicant
                echo -e "\n${info} Servicios detenidos.${reset}"
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
                ;;
            2)
                echo -e "\n${info} Reactivando servicios...${reset}\n"
                sudo systemctl start NetworkManager
                sudo systemctl start wpa_supplicant
                echo -e "\n${info} Servicios reactivados.${reset}"
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
                ;;
            3)
                echo -e "\n${info} Verificando el estado del modo monitor...${reset}\n"
                sudo iwconfig
                echo -e "\n${info} Verificación completada.${reset}"
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
                ;;
            4)
                echo -e "\n${process} ${cyan}Actualizando Script...${reset}\n"
                sudo wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility/main/install.sh -O - | sudo bash
                sudo rm -rf wget-log*
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
                ;;
            0)
                return
                ;;
            *)
                echo -e "\n${error} ${red}Opción no válida, por favor intente de nuevo.${reset}"
                sleep 1
                ;;
        esac
    done
}

while true $x != "ok"
do

# Mostrar banner
fun_banner

# Script para auditoría de redes Wi-Fi utilizando Wifite
echo -e "\n${cyan}Selecciona el tipo de ataque:${reset}\n"
echo -e "${green}1  ${white}Ejecutando Wifite (Por defecto)${reset}"
echo -e "${green}2  ${white}Ataques WPS${reset}"
echo -e "${green}3  ${white}Captura de PMKID (WPA/WPA2)${reset}"
echo -e "${green}4  ${white}Ataques WEP${reset}"
echo -e "${green}5  ${white}Captura de Handshakes (WPA/WPA2)${reset}"
echo -e "${bar}"
echo -e "${green}6  ${white}Crackeo de Handshakes (WPA/WPA2)${reset}"
echo -e "${bar}"
echo -e "${green}7  ${indicator} Verificación de Handshakes Existentes${reset}"
echo -e "${green}8  ${indicator} Verificación de Handshakes Crackeados${reset}"
echo -e "${bar}"
echo -e "${green}9  ${white}Ayuda (Manual de usario)${reset}"
echo -e "${green}10 ${white}Instalar Wifite y Herramientas Esenciales${reset}"
echo -e "${green}11 ${white}Crear Diccionario personalizado${reset}"
echo -e "${green}12 ${white}Instalar Drivers${reset}"
echo -e "${green}13 ${white}Gestionar servicios interferentes${reset}"
echo -e "${green}14 ${white}Información del Sistema y Red${reset}"
echo -e "${bar}"
echo -e "${green}15 $versionSCT${reset}"
echo -e "${bar}"
echo -e "${green}0  ${white}Salir${reset}"
echo -e "\n${barra}"
echo -ne "\n${bold}${yellow} Elige una opción:${white} >> "; read x

case $x in
  1)
    echo -e "\n${process} ${cyan}Ejecutando Wifite (PORDEFECTO)${reset}"
    sudo wifite --ignore-locks --keep-ivs --random-mac -v --daemon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  2)
    echo -e "\n${process} ${cyan}Ejecutando ataques WPS...${reset}"
    sudo wifite --ignore-locks --keep-ivs -p 60 --random-mac -v --wps --daemon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  3)
    echo -e "\n${process} ${cyan}Capturando PMKID (WPA/WPA2)...${reset}"
    crear_diccionario
    sudo wifite --ignore-locks --keep-ivs -p 60 --random-mac -v --pmkid --wpa --dict /usr/share/wordlists/defaultWordList.txt --pmkid-timeout 60 --daemon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  4)
    echo -e "\n${process} ${cyan}Ejecutando ataques WEP...${reset}"
    sudo wifite --ignore-locks --keep-ivs -p 60 --random-mac -v --wep --daemon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  5)
    echo -e "\n${process} ${cyan}Capturando handshakes (WPA/WPA2)...${reset}"
    crear_diccionario
    sudo wifite --ignore-locks --keep-ivs -p 60 --random-mac -v --wpa --dict /usr/share/wordlists/defaultWordList.txt --no-pmkid --daemon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  6)
    echo -e "\n${process} ${cyan}Crackeando handshakes (WPA/WPA2)...${reset}"
    crear_diccionario
    sudo wifite --crack --dict /usr/share/wordlists/defaultWordList.txt --daemon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  7)
    echo -e "\n${process} ${cyan}Verificando handshakes existentes...${reset}"
    sudo wifite --check --daemon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  8)
    echo -e "\n${process} ${cyan}Verificando handshakes crackeados...${reset}"
    sudo wifite --cracked --daemon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  9)
    echo -e "\n${process} ${cyan}Ayuda (MNUAL DE USUARIO)...${reset}"
    sudo ./Install/wifite_help_ES.sh
    echo -e "\nPara más información, consulta el siguiente enlace: ${cyan}https://github.com/kimocoder/wifite2${reset}"
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  10)
    echo -e "\n${process} ${cyan}Instalar wifite y herramientas esenciales...${reset}"
    instalar_wifite_y_herramientas
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  11)
    echo -e "\n${process} ${cyan}Creando diccionario personalizado...${reset}"
    crear_diccionario
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
    ;;
  12)
    echo -e "\n${process} ${cyan}Instalar drivers...${reset}"
    instalar_drivers
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
    ;;
  13)
    echo -e "\n${process} ${cyan}Gestionando servicios interferentes...${reset}"
    gestionar_servicios_interferentes
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
    ;;
  14) 
    echo -e "\n${process} ${cyan}Información del Sistema y Red...${reset}"
    data_system 
    echo -ne "\n${bold}${red}Presiona ENTER ${yellow}para volver al ${green}MENÚ!${reset}"; read
    ;;
  15)
    echo -e "\n${process} ${cyan}Actualizando Script...${reset}\n"
    sudo wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility/main/install.sh -O - | sudo bash
    sudo rm -rf wget-log*
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
    ;;
  0)
    echo -e "\n${info} ${cyan}Saliendo...${reset}"
    exit 0
    ;;
  *)
    echo -e "\n${error} ${red}Opción no válida, por favor intente de nuevo.${reset}"
    sleep 1
esac
done
}

# Ejecución del menú principal
user_interface_menu

# Fin del script
