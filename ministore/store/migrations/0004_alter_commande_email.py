# Generated by Django 5.0.3 on 2024-04-16 09:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('store', '0003_commande'),
    ]

    operations = [
        migrations.AlterField(
            model_name='commande',
            name='email',
            field=models.EmailField(max_length=254),
        ),
    ]
