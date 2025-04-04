#!/usr/bin/env bash
# exit on error
set -o errexit

# Installation des dépendances
pip install -r requirements.txt

# Créer les dossiers nécessaires
mkdir -p ministore/static ministore/media/media

# Entrer dans le répertoire du projet Django
cd ministore

# Supprimer toutes les migrations existantes sauf __init__.py
find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
find . -path "*/migrations/*.pyc" -delete

# Créer les migrations initiales
echo "Making migrations..."
python manage.py makemigrations
python manage.py makemigrations store

# Obtenir le nom de la base de données depuis l'URL
DB_NAME=$(python - <<EOF
import os
import dj_database_url
db_url = os.getenv('DATABASE_URL', '')
if db_url:
    print(dj_database_url.parse(db_url)['NAME'])
EOF
)

if [ ! -z "$DB_NAME" ]; then
    echo "Dropping all tables..."
    psql $DATABASE_URL -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
fi

# Appliquer les migrations
echo "Applying migrations..."
python manage.py migrate
python manage.py migrate store

# Charger les données initiales
echo "Loading initial data..."
python manage.py loaddata store/fixtures/initial_data.json

# Collecter les fichiers statiques
echo "Collecting static files..."
python manage.py collectstatic --noinput

# Copier les fichiers média
cp -r media/media/* media/ || true
rm -rf media/media/ || true
