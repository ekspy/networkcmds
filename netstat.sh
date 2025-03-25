#!/bin/bash

[ $# -ne 1 ] && { echo "Uso: $0 <arquivo_servers>"; exit 1; }
[ ! -f "$1" ] && { echo "Arquivo $1 não encontrado"; exit 1; }

echo "Portas em escuta no sistema local:"
netstat -tuln 2>/dev/null | awk 'NR>2 {print "  " $1 " " $4 " " $6}' && echo "  Concluído" || echo "  Falha ao executar netstat"
