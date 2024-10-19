#!/bin/bash

# Nombre de la aplicación
APP_NAME="GUI wifite "

# Ruta del ejecutable
EXEC_PATH="/usr/share/kali-menu/exec-in-shell \"wifiteutility\""

# Ruta del ícono
ICON_PATH="kali-wifite"

# Archivo .desktop que vamos a crear
# DESKTOP_FILE="~/.local/share/applications/guiwifite.desktop"
DESKTOP_FILE="/usr/share/applications/guiwifite.desktop"

# Crear el archivo .desktop con el contenido necesario
sudo bash -c "cat > $DESKTOP_FILE << EOL
[Desktop Entry]
Name=$APP_NAME
Comment=Python script to automate wireless auditing using aircrack-ng tools
Encoding=UTF-8
Exec=$EXEC_PATH
Icon=$ICON_PATH
StartupNotify=false
Terminal=true
Type=Application
Categories=06-wireless-attacks;
X-Kali-Package=wifite
EOL"

# Asegurar los permisos adecuados para que el archivo sea accesible
sudo chmod 644 $DESKTOP_FILE

# Actualizar la base de datos del menú para que se reflejen los cambios
sudo update-desktop-database

echo "¡El archivo .desktop para $APP_NAME se ha creado exitosamente!"

