#!/usr/bin/env bash
# exit on error
set -o errexit

# Installation des dépendances
pip install -r requirements.txt

# Créer les dossiers nécessaires
mkdir -p ministore/static ministore/media

cd ministore

# Debug: Afficher l'environnement
echo "Current directory: $(pwd)"
echo "Python version: $(python --version)"
echo "Django version: $(python -m django --version)"
echo "Database URL: $DATABASE_URL"

# Appliquer les migrations
echo "Applying migrations..."
python manage.py migrate

# Collecter les fichiers statiques
echo "Collecting static files..."
python manage.py collectstatic --noinput
