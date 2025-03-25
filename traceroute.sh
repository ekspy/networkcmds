#!/bin/bash

[ $# -ne 1 ] && { echo "Uso: $0 <arquivo_servers>"; exit 1; }
[ ! -f "$1" ] && { echo "Arquivo $1 não encontrado"; exit 1; }

while read -r SERVER; do
    echo "Traceroute para $SERVER:"
    traceroute "$SERVER" 2>/dev/null | awk 'NR>1 {print "  " $1 " " $2 " " $3}' && echo "  Concluído" || echo "  Falha ao traçar o caminho"
    echo ""
done < "$1"
