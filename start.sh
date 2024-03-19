#!/bin/bash
set -eu

# Verificar se a pasta de configuração no volume não existe e copiar se for a primeira vez
if [[ ! -d /app/data/bb ]]; then
    echo "Configurando pela primeira vez..."
    # Copiar configuração para o volume
    cp -r /app/code/bb /app/data/bb
    ln -s /app/data/bb /app/code/run
fi

# Remover a pasta de configuração original (se existir) e criar um link simbólico
# rm -rf /app/code/balance-bot/bb/config
# ln -s /app/data/config /app/code/balance-bot/bb/config


# Navegar até o diretório do script bb.js
# cd /app/code/balance-bot

cd /app/code/bb
# Executar o script bb.js com Node.js
node bb
