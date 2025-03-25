#!/bin/bash

[ $# -ne 4 ] && { echo "Uso: $0 <destino> <atraso_transmissao_s> <atraso_propagacao_s> <atraso_fila_s>"; exit 1; }

DESTINO=$1
TRANS=$2
PROP=$3
FILA=$4

PING_OUTPUT=$(ping -c 5 "$DESTINO" 2>/dev/null)
[ $? -eq 0 ] && {
    RTT=$(echo "$PING_OUTPUT" | awk '/rtt min\/avg\/max\/mdev/ {print $4}' | cut -d'/' -f2 | awk '{print $1/1000}')
    [ -n "$RTT" ] && {
        PROC=$(echo "scale=6; $RTT - ($TRANS + $PROP + $FILA)" | bc)
        echo "Atraso de processamento estimado para $DESTINO: $PROC segundos"
    } || echo "Estatísticas não disponíveis"
} || echo "$DESTINO não respondeu ao ping"
