#!/bin/bash
set -eu

chown -R cloudron:cloudron /app/data

# Verificar se a pasta de configuração no volume não existe e copiar se for a primeira vez
if [[ ! -d /app/data/bb ]]; then
    echo "Configurando pela primeira vez..."
    cd /app/data
    # Copiar configuração para o volume
    cp -r /app/code/* /app/data/
    exec /usr/local/bin/gosu cloudron:cloudron ./install.expect
fi

cd /app/data/bb

# Executar o script bb.js com Node.js
echo "==> Starting App"
exec /usr/local/bin/gosu cloudron:cloudron node bb