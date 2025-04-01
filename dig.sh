#!/bin/bash

[ $# -ne 1 ] && { echo "Uso: <servers.txt>"; exit 1; }
[ ! -f "$1" ] && { echo "Arquivo $1 não encontrado"; exit 1; }

while read -r SERVER; do
    echo "Consulta DNS para $SERVER:"
    echo "Registro A:"
    dig +short "$SERVER" A 2>/dev/null || echo "    Falha na consulta"
    echo "Registro MX:"
    dig +short "$SERVER" MX 2>/dev/null || echo "    Sem registro MX"
    echo ""
done < "$1"
