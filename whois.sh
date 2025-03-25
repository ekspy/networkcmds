#!/bin/bash

[ $# -ne 1 ] && { echo "Uso: $0 <arquivo_servers>"; exit 1; }
[ ! -f "$1" ] && { echo "Arquivo $1 não encontrado"; exit 1; }

while read -r SERVER; do
    echo "Whois para $SERVER:"
    whois "$SERVER" 2>/dev/null | grep -E "Domain Name|Registrant|Creation Date" | sed 's/^/  /' && echo "  Concluído" || echo "  Falha na consulta whois"
    echo ""
done < "$1"
