# Generated by Django 4.0.5 on 2022-07-24 23:10

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('main', '0002_alter_planttype_sun_exposer'),
    ]

    operations = [
        migrations.AlterField(
            model_name='planttype',
            name='weather_exposer',
            field=models.CharField(choices=[('EXPOSED', 'Exposed'), ('SHELTERED', 'Sheltered'), ('EXPOSED_OR_SHELTERED', 'Exposed or Sheltered')], default='EXPOSED', max_length=50),
        ),
    ]
