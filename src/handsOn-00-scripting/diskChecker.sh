#!/bin/bash
THRESHOLD=90

while true; do
  USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

  if [ $USAGE -gt $THRESHOLD ]; then
    echo "Advertencia: El uso del disco está por encima del $THRESHOLD% (Actualmente: $USAGE%)"
  else
    echo "El uso del disco es del $USAGE%, todo está bien."
  fi

  sleep 3600  # Esperar una hora antes de volver a comprobar
done
