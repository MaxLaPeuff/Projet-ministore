#!/usr/bin/env bash
# exit on error
set -o errexit

# Installation des dépendances
pip install -r requirements.txt

# Entrer dans le répertoire du projet Django
cd ministore

# Collecter les fichiers statiques
python manage.py collectstatic --no-input

# Appliquer les migrations
python manage.py migrate
