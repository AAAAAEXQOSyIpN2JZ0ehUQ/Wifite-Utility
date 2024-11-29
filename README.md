![logo](https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility/blob/main/Imagenes/Wifite-Utility.png)

# Wifite Utility :octocat: 
## :information_source: Descripción
El script Wifite Utility es una herramienta todo-en-uno diseñada para auditar 
redes inalámbricas mediante el uso de Wifite y otras herramientas esenciales para 
la auditoría de redes Wi-Fi. Esta utilidad automatiza gran parte del proceso de 
instalación de herramientas y drivers necesarios para realizar ataques de redes, 
facilitando el trabajo a pentesters y entusiastas de la seguridad.

Este script proporciona una interfaz gráfica de menú (GUI) amigable para ejecutar 
las funciones más comunes, como la instalación de Wifite, la creación de 
diccionarios personalizados, la instalación de herramientas adicionales, y la 
configuración de drivers específicos para adaptadores de red.

## :computer: Instalación
```bash
cd /opt
sudo rm -rf Wifite-Utility
sudo git clone https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility.git
sudo chmod +x Wifite-Utility/*
sudo chmod +x Wifite-Utility/Install/* 
cd Wifite-Utility
ls -ltha
```

## :key: Acceso Directo
```bash
cd
echo "cd /opt/Wifite-Utility && sudo ./Wifite-Utility.sh" > wifiteutility
sudo chmod +x wifiteutility
sudo mv wifiteutility /usr/local/bin/
cd
```

## :package: Paquete
```bash
sudo apt-get -y update
sudo apt-get install -y wifite
sudo apt install -y hcxdumptool hcxtools
```

## :computer: Crear Desktop
```bash
sudo wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility/refs/heads/main/Install/crear_guiwifite_desktop.sh -O - | sudo bash && sudo rm -rf wget-log*
```

## :computer: Instalación en una Línea
```bash
sudo wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility/main/install.sh -O - | sudo bash && sudo rm -rf wget-log*
```

## :rocket: Modo de Uso

Ejecute el script simplemente ejecuta el siguiente comando `wifiteutility`  en tu terminal y presiona Enter.

```bash
wifiteutility
```

## :star2: Características 

- **Instalación Simplificada de Wifite y Herramientas Esenciales**:  
  - Instala o actualiza Wifite y otras herramientas importantes como hcxdumptool, libpcap, entre otras, con un solo comando.
  
- **Automatización de la Instalación**:  
  - Automatiza todo el proceso de instalación de herramientas y drivers necesarios, eliminando la necesidad de configuraciones manuales. 
  
- **Creación de Diccionarios Personalizados**:  
  - Genera un diccionario optimizado para ataques de fuerza bruta combinando múltiples listas de palabras y filtrando palabras de longitud mínima.
  
- **Gestión de Drivers para Adaptadores Wi-Fi**:  
  - Instala rápidamente drivers para adaptadores Wi-Fi como rtl8188eus, rtl8814au, rtl88xxau, entre otros, asegurando la compatibilidad con auditorías de redes inalámbricas.
  - Facilita la instalación de módulos del kernel y headers necesarios para la compilación de drivers.
  
- **Soporte para Pyrit**:  
  - Instala o actualiza Pyrit para realizar ataques a redes inalámbricas utilizando la aceleración por GPU, con soporte para su compilación desde el código fuente.
  
- **Interfaz Gráfica Amigable**:  
  - Incluye una GUI simple que facilita la navegación por las distintas opciones del script, con un banner personalizado para mostrar información relevante sobre las herramientas utilizadas.

- **Automatización Total**:  
  - El script automatiza todo el proceso, desde la instalación hasta la configuración, para que puedas empezar a auditar redes Wi-Fi sin complicaciones adicionales.

## :hammer_and_wrench: Requisitos 

- Sistema Operativo: Linux/Unix
- Dependencias: Wifite, hcxdumptool, hcxtools, libpcap, Pyrit y otras herramientas de auditoría Wi-Fi.

## :memo: Personalización

Puedes ajustar los comandos y configuraciones del script según tus necesidades modificando el archivo `/opt/Wifite-Utility/wifite-utility.sh`

## :open_file_folder: Estructura del Repositorio

| Icono            | Nombre              | Descripción                               |
|------------------|---------------------|-------------------------------------------|
| :file_folder:    | Documentos          | Carpeta para documentos en general        |
| :file_folder:    | Imágenes            | Carpeta para imágenes del proyecto        |
| :file_folder:    | Install             | Carpeta para scripts de instalación       |
| :page_facing_up: | .gitattributes      | Archivo para configuración de Git         |
| :page_facing_up: | LICENSE             | Archivo de licencia del proyecto          |
| :book:           | README.md           | Archivo de documentación principal        |
| :page_facing_up: | Wifite-Utility.sh   | Script principal de utilidad Wifite       |
| :package:        | install.sh          | Script de instalación automatizada        |
| :page_facing_up: | wifite_help_ES.sh   | Archivo de ayuda en español para Wifite   |

## :star2: Contribuciones

Las contribuciones son bienvenidas. Si tienes ideas para mejorar este script o encuentras algún problema, siéntete libre de abrir un *pull request* o *issue*.

## :warning: Advertencias

- Uso Responsable: Este script está diseñado para ser utilizado en dispositivos y redes que te pertenecen o para las que tienes permiso de uso. No lo utilices para actividades no autorizadas.

## :email: Contacto 
* :busts_in_silhouette: **derv82**: [GitHub](https://github.com/derv82/wifite) - Desarrollador  Wifite
* :busts_in_silhouette: **kimocoder**: [GitHub](https://github.com/kimocoder/wifite2) - Actualización de versión Wifite
* :busts_in_silhouette: **Dzhoni**: [GitHub](https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility) - Colaborador versión GUI

☆ https://t.me/AAAAAEXQOSyIpN2JZ0ehUQ [  ⃘⃤꙰✰ ] ☆
