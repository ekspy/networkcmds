#!/bin/bash

[ $# -ne 1 ] && { echo "Uso: $0 <arquivo_servers>"; exit 1; }
[ ! -f "$1" ] && { echo "Arquivo $1 não encontrado"; exit 1; }

while read -r SERVER; do
    echo "Iperf3 para $SERVER:"
    iperf3 -c "$SERVER" -t 5 2>/dev/null | awk '/sender/ {print "  " $7 " " $8}' && echo "  Concluído" || echo "  Falha ao conectar ou servidor iperf3 não ativo"
    echo ""
done < "$1"
echo "Nota: Cada destino deve ter um servidor iperf3 ativo (iperf3 -s)."
