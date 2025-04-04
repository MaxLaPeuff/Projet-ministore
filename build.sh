#!/usr/bin/env bash
# exit on error
set -o errexit

# Installation des dépendances
pip install -r requirements.txt

# Créer les dossiers nécessaires
mkdir -p ministore/static ministore/media/media

# Entrer dans le répertoire du projet Django
cd ministore

# Créer les migrations initiales
python manage.py makemigrations store

# Appliquer les migrations
python manage.py migrate --noinput

# Charger les données initiales
python manage.py loaddata store/fixtures/initial_data.json

# Collecter les fichiers statiques
python manage.py collectstatic --noinput

# Copier les fichiers média
cp -r media/media/* media/
rm -rf media/media/

# Créer un superuser si nécessaire (optionnel)
# echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@example.com', 'adminpassword') if not User.objects.filter(username='admin').exists() else None" | python manage.py shell
