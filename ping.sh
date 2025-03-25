#!/bin/bash

[ $# -ne 1 ] && { echo "Uso: $0 <servers>"; exit 1; }

while read -r SERVER; do
    echo -n "$SERVER "
    PING_OUTPUT=$(ping -c 5 -q "$SERVER" 2>/dev/null)
    [ $? -eq 0 ] && {
        STATS=$(echo "$PING_OUTPUT" | awk '/round-trip/ {split($4, a, "/"); print a[1] " " a[2] " " a[3] " " a[4]}')
        [ -n "$STATS" ] && echo "$STATS" || echo "Estatísticas não disponíveis"
    } || echo "Não respondeu ao ping"
done < "$1"
