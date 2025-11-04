#!/bin/bash
set -e
set -x  # mostra cada comando no journal
export PYTHONUNBUFFERED=1

cd /home/nacs/projects/sjp

echo "📦 Construindo imagens Docker..."
docker compose build

echo "🗄️ Subindo container do banco..."
docker compose up -d db

echo "⏳ Aguardando banco de dados ficar pronto..."
until [ "$(docker inspect -f '{{.State.Health.Status}}' sjp_db 2>/dev/null)" = "healthy" ]; do
  echo "⏳ Banco ainda não pronto..."
  sleep 2
done
echo "✅ Banco disponível!"

echo "🧩 Aplicando migrações Django..."
docker compose run --rm web python manage.py migrate --noinput

echo "🎨 Coletando arquivos estáticos..."
docker compose run --rm web python manage.py collectstatic --noinput

echo "🚀 Subindo containers Web + Nginx..."
docker compose up -d web nginx pgadmin

echo "✅ Django + Nginx rodando!"

