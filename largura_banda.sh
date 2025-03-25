#!/bin/bash

[ $# -ne 1 ] && { echo "Uso: $0 <servidor_iperf>"; exit 1; }

SERVIDOR=$1
IPERF_OUTPUT=$(iperf3 -c "$SERVIDOR" 2>/dev/null)
[ $? -eq 0 ] && {
    BANDWIDTH=$(echo "$IPERF_OUTPUT" | awk '/sender/ {print $7 " " $8}')
    echo "Largura de banda para $SERVIDOR: $BANDWIDTH"
} || echo "Falha ao conectar ao servidor iperf3 em $SERVIDOR"
