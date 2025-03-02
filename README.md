﻿![logo](https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility/blob/main/Imagenes/Wifite-Utility.png)

# gWifite :octocat: 
**Wifite Utility**  
## :information_source: Descripción

El script **gWifite** es una herramienta todo-en-uno diseñada para auditar redes inalámbricas, funcionando como un complemento para **Wifite**. En lugar de reemplazar a Wifite, **gWifite** facilita su uso al proporcionar una interfaz gráfica de menú (GUI) amigable.

Este script ofrece un acceso más sencillo a funciones comunes como la instalación de Wifite, la creación de diccionarios personalizados, la instalación de herramientas adicionales y la configuración de drivers específicos para adaptadores de red, todo a través de una interfaz intuitiva que simplifica la experiencia del usuario.

**gWifite** está orientado a pentesters y entusiastas de la seguridad, permitiendo una rápida puesta en marcha y optimización de herramientas para auditorías de redes inalámbricas sin complicaciones.

## :computer: Instalación
```bash
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
```

## :key: Acceso Directo
```bash
cd
echo "cd /opt/Wifite-Utility && sudo ./Wifite-Utility.sh" > gwifite
echo "cd /opt/Wifite-Utility && sudo ./Wifite-Utility.sh" > xwifite
sudo chmod +x gwifite xwifite
sudo mv gwifite xwifite /usr/local/bin/
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

Ejecute el script simplemente ejecuta el siguiente comando `gwifite`  en tu terminal y presiona Enter.

```bash
gwifite
```

## :star2: Características 

- **Instalación Simplificada de Herramientas**:  
  - Instala o actualiza Wifite, hcxdumptool, libpcap, Pyrit y otros componentes esenciales con un solo comando.

- **Automatización de la Instalación**:  
  - Automatiza el proceso de instalación y configuración de herramientas y drivers, eliminando la necesidad de configuraciones manuales.

- **Creación de Diccionarios Personalizados**:  
  - Genera diccionarios optimizados para ataques de fuerza bruta, combinando múltiples listas de palabras y filtrando por longitud mínima.

- **Gestión de Drivers para Adaptadores Wi-Fi**:  
  - Instala drivers para adaptadores Wi-Fi como rtl8188eus, rtl8814au, rtl88xxau y más, asegurando compatibilidad con auditorías inalámbricas.
  - Facilita la instalación de módulos del kernel y headers necesarios para compilar drivers.

- **Soporte para Pyrit**:  
  - Instala o actualiza Pyrit, permitiendo realizar ataques a redes Wi-Fi con aceleración por GPU, y con soporte para su compilación desde el código fuente.

- **Interfaz Gráfica Amigable**:  
  - Incluye una GUI sencilla que facilita la navegación y muestra un banner personalizado con información relevante sobre las herramientas utilizadas.

- **Automatización Total**:  
  - El script automatiza todo el proceso, desde la instalación hasta la configuración, para comenzar a auditar redes Wi-Fi sin complicaciones adicionales.

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
| :file_folder:    | images              | Modificaciones e imágenes del proyecto    |
| :file_folder:    | Install             | Carpeta para scripts de instalación       |
| :page_facing_up: | .gitattributes      | Archivo para configuración de Git         |
| :page_facing_up: | LICENSE             | Archivo de licencia del proyecto          |
| :book:           | README.md           | Archivo de documentación principal        |
| :page_facing_up: | Wifite-Utility.sh   | Script principal de utilidad Wifite       |
| :package:        | install.sh          | Script de instalación automatizada        |

## :star2: Contribuciones

Las contribuciones son bienvenidas. Si tienes ideas para mejorar este script o encuentras algún problema, siéntete libre de abrir un *pull request* o *issue*.

## :warning: Advertencias

- Uso Responsable: Este script está diseñado para ser utilizado en dispositivos y redes que te pertenecen o para las que tienes permiso de uso. No lo utilices para actividades no autorizadas.

## :email: Contacto 
* :busts_in_silhouette: **derv82**: [GitHub](https://github.com/derv82/wifite) - Desarrollador  Wifite
* :busts_in_silhouette: **kimocoder**: [GitHub](https://github.com/kimocoder/wifite2) - Actualización de versión Wifite
* :busts_in_silhouette: **Dzhoni**: [GitHub](https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/Wifite-Utility) - Colaborador versión GUI

☆ https://t.me/AAAAAEXQOSyIpN2JZ0ehUQ [  ⃘⃤꙰✰ ] ☆
