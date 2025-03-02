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

# Iconos v1 (adaptados con los de Wifite)
checkmark="${white}[${green}+${white}]${reset}"       # Acción exitosa o algo encontrado
error="${white}[${red}-${white}]${reset}"             # Error o acción fallida
info="${white}[${yellow}*${white}]${reset}"           # nformación o proceso en curso
warning="${yellow}[${red}!${yellow}]${reset}"         # Advertencia o estado desconocido
loading="${white}[${magenta}~${white}]${reset}"       # Indicador de proceso en ejecución
indicator="${red}>${reset}"                           # Indicador general

# Barra de separación
barra="${blue}|--------------------------------------------|${reset}"
bar="${yellow}----------------------------------------------${reset}"

# Comprobación de permisos de root v1
[[ "$(whoami)" != "root" ]] && {
    echo -e "\n${error} ${yellow}Necesitas ejecutar este script como administrador (${red}root${yellow})${reset}."
    echo -e "\n${info} ${green}Intenta: sudo $0${reset}"
    exit 0
}

# Script para auditoría de redes Wi-Fi utilizando Wifite
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

# Función para crear el diccionario de contraseñas
crear_diccionario() {
    # Ruta del archivo de salida
    local output_file="/usr/share/wordlists/defaultWordList.txt"
    
    # Verificar si el diccionario ya existe para evitar sobrescribirlo
    if [[ -f "$output_file" ]]; then
        echo -e "\n${error} El archivo ${output_file} ya existe.${reset}\n"
        return 1
    fi

    echo -e "\n${info} Creando diccionario...${reset}\n"

    # Instalar wordlists si no está instalado
    if ! dpkg -s wordlists &>/dev/null; then
        echo -e "\n${info} Instalando wordlists...${reset}"
        sudo apt install -y wordlists
    fi

    # Verificar si rockyou.txt está disponible, si no, descomprimirlo
    local rockyou="/usr/share/wordlists/rockyou.txt"
    if [[ ! -f "$rockyou" ]]; then
        echo -e "\n${info} Descomprimiendo rockyou.txt...${reset}"
        sudo gzip -d /usr/share/wordlists/rockyou.txt.gz 2>/dev/null
    fi

    # Archivos fuente para el diccionario
    local fuentes=(
        "/usr/share/set/src/fasttrack/wordlist.txt"
        "/usr/share/john/password.lst"
        "/usr/share/nmap/nselib/data/passwords.lst"
        "$rockyou"
        "/usr/share/sqlmap/data/txt/wordlist.txt"
        "/usr/share/dict/wordlist-probable.txt"
    )

    # Verificar que los archivos fuente existen antes de combinarlos
    local archivos_validos=()
    for archivo in "${fuentes[@]}"; do
        [[ -f "$archivo" ]] && archivos_validos+=("$archivo")
    done

    if [[ ${#archivos_validos[@]} -eq 0 ]]; then
        echo -e "\n${error} No se encontraron listas de palabras disponibles.${reset}\n"
        return 1
    fi

    # Combinar, ordenar y eliminar duplicados
    cat "${archivos_validos[@]}" | sort -u | grep -E '\b\w{8,}\b' > "$output_file"

    # Asignar permisos adecuados
    sudo chmod 644 "$output_file"

    # Contar palabras en el diccionario final
    local total=$(wc -l < "$output_file")
    echo -e "\n${checkmark} Diccionario creado en ${output_file} (${total} palabras).${reset}\n"

    return 0
}

gestionar_wps() {
    while true; do
        # Mostrar banner
        fun_banner

        # Obtener información dinámica
        obtener_info() {
          # Detectar la interfaz en modo Monitor
         interfaz=$(iwconfig 2>/dev/null | grep -i "Mode:Monitor" | awk '{print $1}')
          [ -z "$interfaz" ] && interfaz="managed"

         # Detectar el modo
         if [ "$interfaz" != "managed" ]; then
           modo="Monitor"
          else
           modo="managed"
          fi
        }
        obtener_info

        echo -e "\n${white}Interfaz: ${green}${interfaz} ${white}Modo: ${green}${modo} ${reset}"

        echo -e "\n${cyan}Selecciona la opción que deseas realizar:${reset}\n"
        echo -e "${green}1  ${white}Poner la interfaz en modo Monitor${reset}"
        echo -e "${green}2  ${white}Poner la interfaz en modo Managed${reset}"
        echo -e "${bar}"
        echo -e "${green}3  ${white}Detener servicios que interfieren${reset}" # NetworkManager y wpa_supplicant
        echo -e "${green}4  ${white}Reactivar servicios detenidos${reset}" # NetworkManager y wpa_supplicant
        echo -e "${bar}"
        echo -e "${green}5  ${white}Verificar el estado de la interfaz${reset}"
        echo -e "${bar}"
        echo -e "${green}6  ${white}Iniciar Ataque WPS con Bully${reset}"
        echo -e "${green}7  ${white}Iniciar Ataque WPS con Reaver (Modo Predeterminado)${reset}"
        echo -e "${bar}"
        echo -e "${green}0  ${white}Volver al menú principal${reset}"
        echo -e "\n${barra}"
        echo -ne "\n${bold}${yellow} Elige una opción:${white} >> "; read option

        case $option in
            1)
                echo -e "\n${info} Activando modo monitor...${reset}\n"
                sudo ip link set wlan0 down
                sudo iw dev wlan0 interface add wlan0mon type monitor
                sudo ip link set wlan0mon up
                iw dev
                nmcli device status
                echo -e "\n${info} Modo monitor activado.${reset}"
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
                ;;
            2)
                echo -e "\n${info} Reactivando modo managed...${reset}\n"
                sudo ip link set wlan0mon down
                sudo iw dev wlan0mon del
                sudo ip link set wlan0 up
                iw dev
                nmcli device status
                echo -e "\n${info} Modo managed activado.${reset}"
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
                ;;
            3)
                echo -e "\n${info} Deteniendo servicios que pueden interferir...${reset}\n"
                sudo airmon-ng check kill
                sudo systemctl stop NetworkManager
                sudo systemctl stop wpa_supplicant
                echo -e "\n${info} Servicios detenidos.${reset}"
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
                ;;
            4)
                echo -e "\n${info} Reactivando servicios que pueden interferir...${reset}\n"
                sudo systemctl restart NetworkManager
                sudo systemctl restart wpa_supplicant
                echo -e "\n${info} Servicios reactivados.${reset}"
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
                ;;
            5)
                echo -e "\n${info} Verificando el estado de la interfaz...${reset}\n"
                sudo iwconfig
                echo -e "\n${info} Verificación completada.${reset}"
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
                ;;
            6)
                echo -e "\n${info} Iniciando ataque WPS con Bully...${reset}\n"
                # sudo wifite --ignore-locks --keep-ivs -p 60 --random-mac -v --wps --daemon
                sudo wifite -v -i wlan0mon --random-mac --wps --wps-only --bully --ignore-locks --daemon
                echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
                ;;
            7)
                echo -e "\n${info} Iniciando ataque WPS con Reaver...${reset}\n"
                # sudo wifite --ignore-locks --keep-ivs -p 60 --random-mac -v --wps --daemon
                sudo wifite -v -i wlan0mon --random-mac --wps --wps-only --reaver --ignore-locks --daemon
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
        sudo apt install git hcxdumptool hcxtools python2.7-dev python3-dev python3-pip libssl-dev libpcap-dev zlib1g-dev libsqlite3-dev
        sudo apt install -y python3 build-essential libffi-dev
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
        sudo cp pyrit /usr/local/bin/
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
        echo -e "${green}1  ${white}Instalar build-essential, dkms y headers (Necesario para los drivers)${reset}"
        echo -e "${bar}"
        echo -e "${green}2  ${white}Instalar realtek-rtl8188eus-dkms${reset}"
        echo -e "${green}3  ${white}Instalar realtek-rtl8814au-dkms${reset}"
        echo -e "${green}4  ${white}Instalar realtek-rtl8723cs-dkms${reset}"
        echo -e "${green}5  ${white}Instalar realtek-rtl88xxau-dkms${reset}"
        echo -e "${green}6  ${white}Instalar realtek-rtl8188fu-dkms${reset}"
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

# Obtener información dinámica
obtener_info() {
  # Detectar la interfaz en modo Monitor
  interfaz=$(iwconfig 2>/dev/null | grep -i "Mode:Monitor" | awk '{print $1}')
  [ -z "$interfaz" ] && interfaz="managed"

  # Detectar el modo
  if [ "$interfaz" != "managed" ]; then
    modo="Monitor"
  else
    modo="managed"
  fi
}
obtener_info

echo -e "\n${white}Interfaz: ${green}${interfaz} ${white}Modo: ${green}${modo} ${reset}"

echo -e "\n${cyan}Selecciona una opción del menú:${reset}\n"
echo -e "${green}1  ${white}Poner la interfaz en modo monitor${reset}"
echo -e "${green}2  ${white}Poner la interfaz en modo managed${reset}"
echo -e "${bar}"
echo -e "${green}3  ${white}Detener servicios que interfieren${reset}" # NetworkManager y wpa_supplicant
echo -e "${green}4  ${white}Reactivar servicios detenidos${reset}" # NetworkManager y wpa_supplicant
echo -e "${bar}"
echo -e "${green}5  ${white}Verificar el estado de la interfaz${reset}"
echo -e "${bar}"
echo -e "${green}6  ${white}Ejecutar Wifite (Modo Predeterminado)${reset}"
echo -e "${green}7  ${white}Menú de ataques WPS${reset}"
echo -e "${green}8  ${white}Capturar PMKID (WPA/WPA2)${reset}"
echo -e "${green}9  ${white}Ejecutar Ataques WEP${reset}"
echo -e "${green}10 ${white}Capturar Handshakes (WPA/WPA2)${reset}"
echo -e "${bar}"
echo -e "${green}11 ${white}Menú de descifrado (WPA/WPA2) offline${reset}"
echo -e "${bar}"
echo -e "${green}12 ${indicator} Verificar Handshakes Existentes${reset}"
echo -e "${green}13 ${indicator} Verificar Handshakes descifrados${reset}"
echo -e "${bar}"
echo -e "${green}14 ${white}Ayuda y Manual de Usuario${reset}"
echo -e "${bar}"
echo -e "${green}15 ${white}Instalar Wifite y Herramientas Necesarias${reset}"
echo -e "${green}16 ${white}Crear Diccionario Personalizado${reset}"
echo -e "${green}17 ${white}Instalar Controladores de Red (drivers)${reset}"
echo -e "${bar}"
echo -e "${green}18 ${white}Información del Sistema y de la Red${reset}"
echo -e "${bar}"
echo -e "${green}19 $versionSCT${reset}"
echo -e "${bar}"
echo -e "${green}0  ${white}Salir${reset}"
echo -e "\n${barra}"
echo -ne "\n${bold}${yellow} Elige una opción:${white} >> "; read x

case $x in
  1)
    echo -e "\n${info} Activando modo monitor...${reset}\n"
    sudo ip link set wlan0 down
    sudo iw dev wlan0 interface add wlan0mon type monitor
    sudo ip link set wlan0mon up
    iw dev
    nmcli device status
    echo -e "\n${info} Modo monitor activado.${reset}"
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
    ;;
  2)
    echo -e "\n${info} Reactivando modo managed...${reset}\n"
    sudo ip link set wlan0mon down
    sudo iw dev wlan0mon del
    sudo ip link set wlan0 up
    iw dev
    nmcli device status
    echo -e "\n${info} Modo managed activado.${reset}"
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
    ;;
  3)
    echo -e "\n${info} Deteniendo servicios que pueden interferir...${reset}\n"
    sudo airmon-ng check kill
    sudo systemctl stop NetworkManager
    sudo systemctl stop wpa_supplicant
    echo -e "\n${info} Servicios detenidos.${reset}"
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
    ;;
  4)
    echo -e "\n${info} Reactivando servicios que pueden interferir...${reset}\n"
    sudo systemctl restart NetworkManager
    sudo systemctl restart wpa_supplicant
    echo -e "\n${info} Servicios reactivados.${reset}"
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
    ;;
  5)
    echo -e "\n${info} Verificando el estado de la interfaz...${reset}\n"
    sudo iwconfig
    echo -e "\n${info} Verificación completada.${reset}"
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
    ;;

  6)
    echo -e "\n${process} ${cyan}Ejecutar Wifite (Modo Predeterminado)...${reset}"
    sudo wifite --ignore-locks --keep-ivs --random-mac -v --daemon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  7)
    echo -e "\n${process} ${cyan}Ejecutando ataques WPS...${reset}"
    gestionar_wps
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  8)
    echo -e "\n${process} ${cyan}Capturando PMKID (WPA/WPA2)...${reset}"
    crear_diccionario
    sudo wifite --ignore-locks --keep-ivs --random-mac -v --pmkid --skip-crack --daemon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  9)
    echo -e "\n${process} ${cyan}Ejecutando Ataques WEP...${reset}"
    sudo wifite --ignore-locks --keep-ivs --random-mac -v --wep --require-fakeauth --daemon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  10)
    echo -e "\n${process} ${cyan}Capturando Handshakes (WPA/WPA2)...${reset}"
    crear_diccionario
    sudo wifite --ignore-locks --keep-ivs --random-mac -v --wpa --no-pmkid --skip-crack --daemon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  11)
    echo -e "\n${process} ${cyan}Crackear Handshakes (WPA/WPA2)...${reset}"
    crear_diccionario
    sudo wifite --crack --dict /usr/share/wordlists/defaultWordList.txt --daemon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  12)
    echo -e "\n${process} ${cyan}Verificar Handshakes Existentes...${reset}"
    sudo wifite --check --daemon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  13)
    echo -e "\n${process} ${cyan}Verificar Handshakes Crackeados...${reset}"
    sudo wifite --cracked --daemon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  14)
    echo -e "\n${process} ${cyan}Ayuda y Manual de Usuario...${reset}"
    sudo /opt/Wifite-Utility/Install/wifite_help_ES.sh 
    echo -e "\nPara más información, consulta el siguiente enlace: ${cyan}https://github.com/kimocoder/wifite2${reset}"
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  15)
    echo -e "\n${process} ${cyan}Instalar Wifite y Herramientas Necesarias...${reset}"
    instalar_wifite_y_herramientas
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  16)
    echo -e "\n${process} ${cyan}Crear Diccionario Personalizado...${reset}"
    crear_diccionario
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
    ;;
  17)
    echo -e "\n${process} ${cyan}Instalar drivers de Red...${reset}"
    instalar_drivers
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
    ;;
  18) 
    echo -e "\n${process} ${cyan}Información del Sistema y de la Red...${reset}"
    data_system 
    echo -ne "\n${bold}${red}Presiona ENTER ${yellow}para volver al ${green}MENÚ!${reset}"; read
    ;;
  19)
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
