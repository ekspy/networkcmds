#!/bin/bash

[ $# -ne 2 ] && { echo "Uso: $0 <distancia_km> <velocidade_km_s>"; exit 1; }

D=$1  # km
V=$2  # km/s

ATRASO_PROP=$(echo "scale=6; $D / $V" | bc)
echo "Atraso de propagação: $ATRASO_PROP segundos"
