# Generated by Django 4.0.5 on 2022-12-24 22:16

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='agent_id',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
    ]
