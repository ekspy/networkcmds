#!/bin/bash

[ $# -ne 1 ] && { echo "Uso: $0 <destino>"; exit 1; }

DESTINO=$1
PING_OUTPUT=$(ping -c 5 "$DESTINO" 2>/dev/null)
[ $? -eq 0 ] && {
    AVG_RTT=$(echo "$PING_OUTPUT" | awk '/rtt min\/avg\/max\/mdev/ {print $4}' | cut -d'/' -f2)
    [ -n "$AVG_RTT" ] && echo "Latência média para $DESTINO: $AVG_RTT ms" || echo "Estatísticas não disponíveis"
} || echo "$DESTINO não respondeu ao ping"
