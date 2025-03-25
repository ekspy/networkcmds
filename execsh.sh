#!/bin/bash

ls *.sh >/dev/null 2>&1 && {
    chmod a+x *.sh && echo "Todos os arquivos .sh agora são executáveis" || echo "Erro ao alterar permissões"
} || echo "Nenhum arquivo .sh encontrado no diretório atual"
