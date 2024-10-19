#!/bin/bash
clear

# Imprimir encabezado
echo -e "\n\033[1;32m   .               .    "
echo -e " \033[1;32m.´  ·  .     .  ·  \`.     \033[1;32mwifite2 2.7.0\033[0m"
echo -e " \033[1;32m:  :  :  \033[1;37m (¯)\033[1;32m  :  :  :   \033[1;37m un auditor de redes inalámbricas por derv82\033[0m"
echo -e " \033[1;32m\`·  ·  \`\033[1;37m  /¯\\ \033[1;32m·  ·  \`·   \033[1;37m mantenido por kimocoder\033[0m"
echo -e " \033[1;32m  \`     \033[1;37m /¯¯¯\\    \033[1;32m \`      \033[1;34mhttps://github.com/kimocoder/wifite2\033[0m"

# Opciones
echo -e "\n\033[1;34mOpciones:\033[0m"
echo -e "  \033[1;33m-h, --help\033[0m                                 \033[1;36mMuestra este mensaje de ayuda y sale\033[0m"

# Configuraciones
echo -e "\n\033[1;34mCONFIGURACIONES:\033[0m"
echo -e "  -v, --verbose\033[0m                               \033[1;32mMuestra más opciones (\033[1;33m-h -v\033[0m). Imprime comandos y\033[0m"
echo -e "                                              \033[1;32msalidas. (\033[1;31mpredeterminado: \033[0msilencioso\033[1;31m)\033[0m"
echo -e "  -i [interfaz]\033[0m                               \033[1;32mInterfaz inalámbrica a usar, por ejemplo, \033[1;33mwlan0mon\033[0m\033[1;32m (\033[1;31mpredeterminado: \033[0mpreguntar\033[1;31m)\033[0m"
echo -e "  -c [canal]\033[0m                                  \033[1;32mCanal inalámbrico a escanear, por ejemplo, \033[1;33m1,3-6\033[0m\033[1;32m (\033[1;31mpredeterminado: \033[0mtodos los canales de 2Ghz\033[1;31m)\033[0m"
echo -e "  -inf, --infinite\033[0m                            \033[1;32mHabilita el modo de ataque infinito. Modifica el\033[0m"
echo -e "                                              \033[1;32mtiempo de escaneo con \033[1;33m-p\033[0m (\033[1;31mpredeterminado: \033[0mdesactivado\033[1;31m)\033[0m"
echo -e "  -mac, --random-mac\033[0m                          \033[1;32mAleatoriza la dirección MAC de la tarjeta inalámbrica\033[0m"
echo -e "                                              \033[1;32m(\033[1;31mpredeterminado: \033[0mdesactivado\033[1;31m)\033[0m"
echo -e "  -p [tiempo_escaneo]\033[0m                         \033[1;32mPillage: Ataca todos los objetivos después del\033[0m"
echo -e "                                              \033[1;32mtiempo_escaneo (\033[1;36msegundos\033[0m)\033[0m"
echo -e "  --kill\033[0m                                      \033[1;32mMata procesos que conflicten con \033[1;33mAirmon/Airodump\033[0m"
echo -e "                                              \033[1;32m(\033[1;31mpredeterminado: \033[0mdesactivado\033[1;31m)\033[0m"
echo -e "  -pow [min_potencia], --power [min_potencia]\033[0m \033[1;32mAtaca cualquier objetivo con al menos \033[1;33mmin_potencia\033[0m"
echo -e "                                              \033[1;32mde señal\033[0m"
echo -e "  --skip-crack\033[0m                                \033[1;32mOmite el desciframiento de handshakes/pmkid\033[0m"
echo -e "                                              \033[1;32mcapturados (\033[1;31mpredeterminado: \033[0mdesactivado\033[1;31m)\033[0m"
echo -e "  -first [ataque_max], --first [ataque_max]\033[0m \033[0m  \033[1;32mAtaca los primeros \033[1;33mataque_max\033[0m objetivos\033[0m"
echo -e "  -ic, --ignore-cracked\033[0m                       \033[1;32mOculta objetivos previamente descifrados\033[0m"
echo -e "                                              \033[1;32m(\033[1;31mpredeterminado: \033[0mdesactivado\033[1;31m)\033[0m"
echo -e "  --clients-only\033[0m                              \033[1;32mMuestra solo objetivos que tengan \033[1;33mclientes\033[0m asociados\033[0m"
echo -e "                                              \033[1;32m(\033[1;31mpredeterminado: \033[0mdesactivado\033[1;31m)\033[0m"
echo -e "  --nodeauths\033[0m                                 \033[1;32mModo pasivo: Nunca desautentica clientes\033[0m"
echo -e "                                              \033[1;32m(\033[1;31mpredeterminado: \033[0mdesautenticar objetivos\033[1;31m)\033[0m"
echo -e "  --daemon\033[0m                                    \033[1;32mVuelve a poner el dispositivo en modo gestionado\033[0m"
echo -e "                                              \033[1;32mdespués de salir (\033[1;31mpredeterminado: \033[0mdesactivado\033[1;31m)\033[0m"

# WEP
echo -e "\n\033[1;34mWEP:\033[0m"
echo -e "  --wep                                       \033[1;32mMuestra solo redes encriptadas con \033[1;33mWEP\033[0m"
echo -e "  --require-fakeauth                          \033[1;32mFalla ataques si la autenticación falsa falla\033[0m"
echo -e "                                              \033[1;32m(\033[1;31mpredeterminado: \033[0mdesactivado\033[1;31m)\033[0m"
echo -e "  --keep-ivs                                  \033[1;32mRetiene archivos \033[1;33m.IVS\033[0m \033[1;32my los reutiliza al\033[0m"
echo -e "                                              \033[1;32mdescifrar (\033[1;31mpredeterminado: \033[0mdesactivado\033[1;31m)\033[0m"

# WPA
echo -e "\n\033[1;34mWPA:\033[0m"
echo -e "  --wpa                                       \033[1;32mMuestra solo redes encriptadas con \033[1;33mWPA\033[0m (\033[1;36mincluye WPS\033[0m)\033[0m"
echo -e "  --new-hs                                    \033[1;32mCaptura nuevos \033[1;33mhandshakes\033[0m, ignora \033[1;33mhandshakes\033[0m"
echo -e "                                              \033[1;32mexistentes en \033[1;33mhs\033[0m (\033[1;31mpredeterminado: \033[0mdesactivado\033[1;31m)\033[0m"
echo -e "  --dict \033[1;33m[archivo]\033[0m                            \033[1;32mArchivo que contiene contraseñas para\033[0m"
echo -e "                                              \033[1;32mdesciframiento (\033[1;36mpredeterminado: \033[0m/usr/share/dict/wordlist-probable.txt\033[1;36m)\033[0m"

# WPS
echo -e "\n\033[1;34mWPS:\033[0m"
echo -e "  --wps                                       \033[1;32mMuestra solo redes habilitadas para \033[1;33mWPS\033[0m"
echo -e "  --wps-only                                  \033[1;32mUsa solo ataques \033[1;33mWPS PIN\033[0m & \033[1;33mPixie-Dust\033[0m \033[1;32m(\033[1;31mpredeterminado: \033[0mdesactivado\033[1;31m)\033[0m"
echo -e "  --bully                                     \033[1;32mUsa el programa \033[1;33mbully\033[0m para ataques \033[1;33mWPS PIN\033[0m & \033[1;33mPixie-Dust\033[0m \033[1;32m(\033[1;31mpredeterminado: \033[0mreaver\033[1;31m)\033[0m"
echo -e "  --reaver                                    \033[1;32mUsa el programa \033[1;33mreaver\033[0m para ataques \033[1;33mWPS PIN\033[0m \033[1;32my \033[1;33mPixie-Dust\033[0m \033[1;32m(\033[1;33mpredeterminado: \033[0mreaver\033[1;32m)\033[0m"
echo -e "  --ignore-locks                              \033[1;32mNo detiene el ataque \033[1;33mWPS PIN\033[0m si el AP se \033[1;33mbloquea\033[0m \033[1;32m(\033[1;31mpredeterminado: \033[0mdetener\033[1;31m)\033[0m"

# PMKID
echo -e "\n\033[1;34mPMKID:\033[0m"
echo -e "  --pmkid                                     \033[1;32mUsa solo captura \033[1;33mPMKID\033[0m, evita otros ataques \033[1;33mWPS\033[0m \033[1;32my \033[1;33mWPA\033[0m \033[1;32m(\033[1;31mpredeterminado: \033[0mdesactivado\033[1;31m)\033[0m"
echo -e "  --no-pmkid                                  \033[1;32mNo usa captura \033[1;33mPMKID\033[0m \033[1;32m(\033[1;31mpredeterminado: \033[0mdesactivado\033[1;31m)\033[0m"
echo -e "  --pmkid-timeout \033[1;33m[seg]\033[0m                       \033[1;32mTiempo de espera para captura \033[1;33mPMKID\033[0m \033[1;32m(\033[1;33mpredeterminado: \033[0m300 segundos\033[1;32m)\033[0m"

# Comandos
echo -e "\n\033[1;34mCOMANDOS:\033[0m"
echo -e "  --cracked                                   \033[1;32mImprime puntos de acceso previamente \033[1;33mdescifrados\033[0m"
echo -e "  --check \033[1;33m[archivo]\033[0m                           \033[1;32mMuestra comandos para descifrar un \033[1;33mhandshake\033[0m capturado\033[0m"
