#!/bin/bash

SOURCE_DIR="C:\Users\Pol Marsol\OneDrive\Escritorio\UNIVERSITAT"

BACKUP_DIR="G:\Mi unidad\Universitat copia"

DATE=$(date +'%Y-%m-%d_%H-%M-%S')

BACKUP_FILE="backup_$DATE.tar.gz"

tar -czf $BACKUP_DIR/$BACKUP_FILE $SOURCE_DIR

if [ $? -eq 0 ]; then
    echo "Còpia de seguretat completada: $BACKUP_DIR/$BACKUP_FILE"
else
    echo "Error: La còpia de seguretat ha fallat."
fi
