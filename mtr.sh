#!/bin/bash

[ $# -ne 1 ] && { echo "Uso: $0 <arquivo_servers>"; exit 1; }
[ ! -f "$1" ] && { echo "Arquivo $1 não encontrado"; exit 1; }

while read -r SERVER; do
    echo "MTR para $SERVER:"
    mtr --report -c 10 "$SERVER" 2>/dev/null | awk 'NR>2 {print "  " $1 " " $2 " " $6 "ms"}' && echo "  Concluído" || echo "  Falha ao executar MTR"
    echo ""
done < "$1"
