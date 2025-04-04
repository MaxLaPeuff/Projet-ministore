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

# Supprimer la base de données si elle existe
python manage.py reset_db --noinput || true

# Créer les migrations initiales pour toutes les applications
python manage.py makemigrations
python manage.py makemigrations store

# Appliquer les migrations
python manage.py migrate
python manage.py migrate store

# Charger les données initiales
python manage.py loaddata store/fixtures/initial_data.json

# Collecter les fichiers statiques
python manage.py collectstatic --noinput

# Copier les fichiers média
cp -r media/media/* media/ || true
rm -rf media/media/ || true
