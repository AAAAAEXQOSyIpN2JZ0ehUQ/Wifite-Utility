#!/bin/bash

# Nombre de la aplicación
APP_NAME="GUI-Wifite"

# Ruta del ejecutable
EXEC_PATH="/usr/share/kali-menu/exec-in-shell \"wifiteutility\""

# Ruta del ícono
ICON_PATH="kali-wifite"

# Rutas de los archivos .desktop
APPLICATIONS_DESKTOP_FILE="/usr/share/applications/kali-guiwifite.desktop"
KALI_MENU_DESKTOP_FILE="/usr/share/kali-menu/applications/kali-guiwifite.desktop"

# Contenido del archivo .desktop
DESKTOP_ENTRY="[Desktop Entry]
Name=$APP_NAME
Comment=Python script to automate wireless auditing using aircrack-ng tools
Encoding=UTF-8
Exec=$EXEC_PATH
Icon=$ICON_PATH
StartupNotify=false
Terminal=true
Type=Application
Categories=06-wireless-attacks;
X-Kali-Package=wifite"

# Función para crear el archivo .desktop
create_desktop_file() {
    local file_path="$1"
    echo "$DESKTOP_ENTRY" | sudo tee "$file_path" > /dev/null
    sudo chmod 644 "$file_path"
    echo "¡El archivo .desktop en $file_path se ha creado exitosamente!"
}

# Crear el archivo .desktop en /usr/share/applications
create_desktop_file "$APPLICATIONS_DESKTOP_FILE"

# Crear el archivo .desktop en /usr/share/kali-menu/applications
create_desktop_file "$KALI_MENU_DESKTOP_FILE"

# Actualizar la base de datos del menú para reflejar los cambios
sudo update-desktop-database
sudo updatedb

echo "Todos los archivos .desktop han sido creados y la base de datos del menú ha sido actualizada."
