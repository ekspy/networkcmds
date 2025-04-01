#!/bin/bash

[ $# -ne 1 ] && { echo "Uso: $0 <arquivo_servers>"; exit 1; }
[ ! -f "$1" ] && { echo "Arquivo $1 não encontrado"; exit 1; }

while read -r SERVER; do
    echo "Consulta DNS para $SERVER:"

    echo "Registro A:"
    A_OUTPUT=$(dig +short "$SERVER" A 2>/dev/null)
    [ -n "$A_OUTPUT" ] && echo "$A_OUTPUT" || echo "  Sem registro A"

    echo "Registro AAAA:"
    AAAA_OUTPUT=$(dig +short "$SERVER" AAAA 2>/dev/null)
    [ -n "$AAAA_OUTPUT" ] && echo "$AAAA_OUTPUT" || echo "  Sem registro AAAA"

    ROOT_SERVER=${SERVER#www.}
    echo "Registro MX (para $ROOT_SERVER):"
    MX_OUTPUT=$(dig +short "$ROOT_SERVER" MX 2>/dev/null)
    [ -n "$MX_OUTPUT" ] && echo "$MX_OUTPUT" || echo "  Sem registro MX"

    echo "Registro NS (para $ROOT_SERVER):"
    NS_OUTPUT=$(dig +short "$ROOT_SERVER" NS 2>/dev/null)
    [ -n "$NS_OUTPUT" ] && echo "$NS_OUTPUT" || echo "  Sem registro NS"

    if [ -n "$A_OUTPUT" ]; then
        FIRST_IP=$(echo "$A_OUTPUT" | head -n 1)
        echo "Consulta inversa (PTR) para $FIRST_IP:"
        PTR_OUTPUT=$(dig +short -x "$FIRST_IP" 2>/dev/null)
        [ -n "$PTR_OUTPUT" ] && echo "$PTR_OUTPUT" || echo "  Sem registro PTR"
    else
        echo "Consulta inversa (PTR): Não aplicável (sem registro A)"
    fi

    echo ""
done < "$1"
