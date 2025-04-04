#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Starting build script..."
echo "Current directory: $(pwd)"

# Installation des dépendances
pip install -r requirements.txt

# Créer les dossiers nécessaires
mkdir -p ministore/static ministore/media

# S'assurer d'être dans le bon répertoire
cd "$(dirname "$0")/ministore"
echo "Changed to directory: $(pwd)"

# Debug: Afficher l'environnement
echo "Python version: $(python --version)"
echo "Django version: $(python -m django --version)"
echo "Database URL: $DATABASE_URL"
echo "Listing current directory:"
ls -la

# Vérifier si les migrations existent
echo "Checking migrations..."
ls -la store/migrations/

# Appliquer les migrations avec plus de verbosité
echo "Applying migrations..."
python manage.py showmigrations
python manage.py migrate --plan
python manage.py migrate --verbosity 3

# Collecter les fichiers statiques
echo "Collecting static files..."
python manage.py collectstatic --noinput
