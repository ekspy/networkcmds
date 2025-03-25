#!/bin/bash

[ $# -ne 1 ] && { echo "Uso: $0 <destino>"; exit 1; }

DESTINO=$1
PING_OUTPUT=$(ping -c 10 "$DESTINO" 2>/dev/null)
[ $? -eq 0 ] && {
    LOSS=$(echo "$PING_OUTPUT" | awk '/packet loss/ {print $6}')
    echo "Perda de pacotes para $DESTINO: $LOSS"
} || echo "$DESTINO não respondeu ao ping"
