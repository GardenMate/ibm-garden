from pyexpat import model
from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class PlantType(models.Model):
    plant_name = models.CharField(max_length=200)
    plant_type = models.CharField(max_length=200)
    plant_size_height = models.IntegerField()
    plant_size_spread = models.IntegerField()
    plant_max_size_time = models.DurationField()
    plant_harvest_length = models.DurationField()
    ## sun_exposer - create a lookup table


class Plant(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='plant', null=True)
    plant_type = models.ForeignKey(PlantType, on_delete=models.SET_NULL, related_name='plant', null= True)
    plant_current_size_height = models.IntegerField()
    plant_current_size_spread = models.IntegerField()
    planted_date = models.DateTimeField()
    ## planted_soil - create a relation between soiltype and plant
