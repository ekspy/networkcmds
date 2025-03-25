#!/bin/bash

[ $# -ne 2 ] && { echo "Uso: $0 <tamanho_pacote_bytes> <taxa_transmissao_mbps>"; exit 1; }

L=$1  # bytes
R=$2  # Mbps

L_BITS=$((L * 8))
R_BPS=$((R * 1000000))
ATRASO_TRANS=$(echo "scale=6; $L_BITS / $R_BPS" | bc)
echo "Atraso de transmissão: $ATRASO_TRANS segundos"
