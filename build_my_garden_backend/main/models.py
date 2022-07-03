from django.db import models
from accounts.models import User

# Create your models here.
# The plant model
class PlantType(models.Model):
    FULL_SUN = "FULL_SUN"
    PARTIAL_SUN = "PARTIAL_SUN"
    FULL_OR_PARTIAL = "PARTIAL _OR_FULL_SUN"

    SUN_EXPOSER_CHOICES = [
        (FULL_SUN, "Full Sunlight"),
        (PARTIAL_SUN, "Partial Sunlight"),
        (FULL_OR_PARTIAL, "Full Sunlight or Partial Sunlight"),
    ]

    plant_name = models.CharField(max_length=200)
    plant_type = models.CharField(max_length=200)
    plant_size_height = models.IntegerField()
    plant_size_spread = models.IntegerField()
    plant_max_size_time = models.DurationField()
    plant_harvest_length = models.DurationField()
    sun_exposer = models.CharField(max_length=50, choices=SUN_EXPOSER_CHOICES, default=FULL_OR_PARTIAL)

    def __str__(self) -> str:
        return self.plant_name

# Season model
class Season(models.Model):
    FALL = "FALL"
    WINTER = "WINTER"
    SPRING = "SPRING"
    SUMMER = "SUMMER"

    SEASON_CHOICES = [
        (FALL, "Fall"),
        (WINTER, "Winter"),
        (SPRING, "Spring"),
        (SUMMER, "Summer"),
    ]

    season = models.CharField(max_length=20, choices=SEASON_CHOICES, default=SPRING)

    def __str__(self) -> str:
        return self.season


# User plant model
class Plant(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='plant', null=True)
    plant_type = models.ForeignKey(PlantType, on_delete=models.SET_NULL, related_name='plant', null= True)
    plant_current_size_height = models.IntegerField()
    plant_current_size_spread = models.IntegerField()
    planted_date = models.DateTimeField()
    ## planted_soil - create a relation between soiltype and plant

# Relation between Plant and Season
class PlantSupportingSeason(models.Model):
    plant_type = models.ForeignKey(PlantType, on_delete=models.SET_NULL, related_name='plant_supporting_season', null= True)
    season = models.ForeignKey(Season, on_delete=models.CASCADE, related_name='plant_supporting_season', null = True) 

    def __str__(self) -> str:
        return self.plant_type +  "<->" + self.season
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

