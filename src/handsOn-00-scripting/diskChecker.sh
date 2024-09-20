#!/bin/bash
THRESHOLD=90

 USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

  if [ $USAGE -gt $THRESHOLD ]; then
    echo "Advertencia: L'ús del disc està per sobre del $THRESHOLD% (Actualment: $USAGE%)"
  else
    echo "L'ús del disc és del $USAGE%, tot està bé."
  fi
