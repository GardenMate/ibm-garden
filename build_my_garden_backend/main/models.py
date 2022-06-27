from django.db import models
from django.contrib.auth.models import User

# Create your models here.

# Soil type model
class SoilType(models.Model):
    soil_name = models.CharField(max_length=200)
    soil_description = models.TextField(max_length=200)
    soil_degradation_duration = models.DurationField()

# Soil model
class Soil(models.Model):
    # Account ID
    account_id = models.ForeignKey(User, on_delete=models.CASCADE, related_name='soil_account', null=True)
    soil_type_id = models.ForeignKey(SoilType, on_delete=models.CASCADE, related_name='soil_type', null= True)
    soil_current_degradation = models.FloatField()