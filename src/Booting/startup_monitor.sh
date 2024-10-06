#!/bin/bash

# Configuració de les variables d'entorn
export PATH=$PATH:/usr/local/sbin:/usr/local/bin

# Reiniciar serveis crítics si han estat actualitzats
sudo systemctl restart ssh.service
sudo systemctl restart apache2.service

# Comprovar l'estat dels serveis i registrar-ho
{
    echo "Estat dels serveis - $(date)"
    systemctl status ssh.service
    systemctl status apache2.service
} >> ~/service_status.log
