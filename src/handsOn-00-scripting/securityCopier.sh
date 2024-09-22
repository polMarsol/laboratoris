#!/bin/bash

SOURCE_DIR="" # Directori d'origen de la còpia de seguretat
BACKUP_DIR="" # Directori de destí de la còpia de seguretat

echo "SOURCE_DIR: $SOURCE_DIR"
echo "BACKUP_DIR: $BACKUP_DIR"

DATE=$(date +'%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="backup_$DATE.tar.gz"

tar -czf "$BACKUP_DIR/$BACKUP_FILE" "$SOURCE_DIR"

if [ $? -eq 0 ]; then
    echo "Còpia de seguretat completada: $BACKUP_DIR/$BACKUP_FILE"
else
    echo "Error: La còpia de seguretat ha fallat."
fi
