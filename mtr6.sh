#!/bin/bash

[ $# -ne 1 ] && { echo "Uso: $0 <arquivo_servers>"; exit 1; }
[ ! -f "$1" ] && { echo "Arquivo $1 não encontrado"; exit 1; }

while read -r SERVER; do
    echo "MTR para $SERVER:"
    sudo mtr -6 --report -c 10 "$SERVER" 2>/dev/null || echo "  Falha ao executar MTR"
    echo ""
done < "$1"
