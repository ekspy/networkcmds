#!/bin/bash

[ $# -ne 3 ] && { echo "Uso: $0 <tamanho_pacote_bits> <taxa_chegada_pacotes_s> <taxa_transmissao_bps>"; exit 1; }

L=$1  # bits
A=$2  # pacotes/s
R=$3  # bps

LOAD=$(echo "scale=6; ($L * $A) / $R" | bc)
[ "$(echo "$LOAD < 1" | bc)" -eq 1 ] && echo "Carga: $LOAD (atraso de fila finito)" || echo "Carga: $LOAD (fila cresce indefinidamente)"
