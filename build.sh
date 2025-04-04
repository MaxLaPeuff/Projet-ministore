#!/usr/bin/env bash
# exit on error
set -o errexit

# Installation des dépendances
pip install -r requirements.txt

# Créer les dossiers nécessaires
mkdir -p ministore/static ministore/media

# Entrer dans le répertoire du projet Django
cd ministore

# Créer les migrations si elles n'existent pas
python manage.py makemigrations

# Appliquer les migrations
python manage.py migrate --noinput

# Collecter les fichiers statiques
python manage.py collectstatic --noinput
