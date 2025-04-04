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

# Réinitialiser la base de données via Django shell
echo "Resetting database..."
python manage.py shell << EOF
from django.db import connection
cursor = connection.cursor()
cursor.execute("""
    SELECT tablename FROM pg_tables
    WHERE schemaname = 'public'
""")
tables = cursor.fetchall()
with connection.cursor() as cursor:
    for table in tables:
        cursor.execute(f'DROP TABLE IF EXISTS "{table[0]}" CASCADE')
    cursor.execute('COMMIT')
EOF

# Créer les migrations initiales
echo "Making migrations..."
python manage.py makemigrations
python manage.py makemigrations store

# Appliquer les migrations
echo "Applying migrations..."
python manage.py migrate --no-input
python manage.py migrate store --no-input

# Charger les données initiales
echo "Loading initial data..."
python manage.py loaddata store/fixtures/initial_data.json

# Collecter les fichiers statiques
echo "Collecting static files..."
python manage.py collectstatic --noinput

# Copier les fichiers média
cp -r media/media/* media/ || true
rm -rf media/media/ || true
