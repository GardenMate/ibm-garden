from django.db import models
from django.core.validators import MaxValueValidator, MinValueValidator
from accounts.models import User
import os

def get_image_path(instance, filename):
    '''Used to get the id of the plants to save the image file'''
    return os.path.join("upload", "Plants",str(instance.id), filename)


# Create your models here.
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


# Soil type model
class SoilType(models.Model):
    LOAM = "LOAM"
    SAND = "SAND"
    CLAY = "CLAY"
    CHALK = "CHALK"

    SOIL_CHOICES = [
        (LOAM, "Loam"),
        (SAND, "Sand"),
        (CLAY, "Clay"),
        (CHALK, "Chalk"),
    ]

    soil_name = models.CharField(max_length=20, choices=SOIL_CHOICES)
    soil_description = models.TextField()

    def __str__(self) -> str:
        return str(self.id) + ". " +self.soil_name


# The MOISTURE LEVEL model
class MoistureLevel(models.Model):
    # Moister Level Type
    MOIST_BUT_WELL_DRAINED = "MOIST_BUT_WELL_DRAINED"
    POORLY_DRAINED = "POORLY_DRAINED"
    WELL_DRAINED = "WELL_DRAINED"

    MOISTURE_LEVEL_CHOICE = [
        (MOIST_BUT_WELL_DRAINED, "Moist But Well Drained"),
        (POORLY_DRAINED, "Poorly Drained"),
        (WELL_DRAINED, "Well Drained"),
    ]

    plant_moisture_level = models.CharField(max_length=50, choices=MOISTURE_LEVEL_CHOICE, default=WELL_DRAINED)

    def __str__(self) -> str:
        return  str(self.id) + ". " +self.plant_moisture_level

# The PH level model
class PhLevel(models.Model):
    # PH Level
    ACIDIC = "ACIDIC"
    ALKALINE = "ALKALINE"
    NEUTRAL = "NEUTRAL"

    PH_LEVEL_CHOICE = [
        (ACIDIC, "Acidic"),
        (ALKALINE, "Alkaline"),
        (NEUTRAL, "Neutral")
    ]
    ph_level = models.CharField(max_length=20, choices=PH_LEVEL_CHOICE, default=NEUTRAL)

    def __str__(self) -> str:
        return  str(self.id) + ". " +self.ph_level

# The plant model
class PlantType(models.Model):
    # Sun Exposer Lookup
    FULL_SUN = "FULL_SUN"
    PARTIAL_SUN = "PARTIAL_SUN"
    FULL_OR_PARTIAL = "FULL_OR_PARTIAL_SUN"

    SUN_EXPOSER_CHOICES = [
        (FULL_SUN, "Full Sunlight"),
        (PARTIAL_SUN, "Partial Sunlight"),
        (FULL_OR_PARTIAL, "Full Sunlight or Partial Sunlight"),
    ]

    # Wearther Expose Lookup
    EXPOSED = "EXPOSED"
    SHELTERED = "SHELTERED"
    EXPOSED_OR_SHELTERED = "EXPOSED_OR_SHELTERED"

    WEATHER_EXPOSER_CHOICES = [
        (EXPOSED, "Exposed"),
        (SHELTERED, "Sheltered"),
        (EXPOSED_OR_SHELTERED, "Exposed or Sheltered"),
    ]

    plant_name = models.CharField(max_length=255)
    plant_scientific_name = models.CharField(max_length=255)
    plant_description = models.TextField()
    plant_type = models.CharField(max_length=200)
    plant_size_max_height_lowest = models.DecimalField(max_digits=5, decimal_places=2)
    plant_size_max_height_highest = models.DecimalField(max_digits=5, decimal_places=2)
    plant_size_max_spread_lowest = models.DecimalField(max_digits=5, decimal_places=2)
    plant_size_max_spread_highest = models.DecimalField(max_digits=5, decimal_places=2)
    plant_max_size_time_lowest = models.DurationField()
    plant_max_size_time_highest = models.DurationField()
    plant_harvest_length = models.DurationField()
    planting_season = models.ManyToManyField(Season, related_name='plant_planting_season')
    plant_harvest_season = models.ManyToManyField(Season, related_name="plant_harvest_season")
    sun_exposer = models.CharField(max_length=50, choices=SUN_EXPOSER_CHOICES, default=FULL_OR_PARTIAL)
    weather_exposer = models.CharField(max_length=50, choices=WEATHER_EXPOSER_CHOICES, default=EXPOSED)
    # The following temperature is stored in degree celicius
    temperature_tolarence = models.DecimalField(max_digits=5, decimal_places=2, validators=[MinValueValidator(-273.15), MaxValueValidator(56.7)]) 
    # The following fields are information about soil
    soil = models.ManyToManyField(SoilType, related_name="plant")
    plant_moisture_level = models.ManyToManyField(MoistureLevel, related_name="plant")
    ph_level = models.ManyToManyField(PhLevel, related_name="plant")
    # The following field are steps to grow
    plant_how_to_cultivate = models.TextField()
    plant_how_to_propagate = models.TextField()
    plant_how_to_garden_type = models.TextField()
    plant_how_to_pruning = models.TextField()
    plant_how_to_pests = models.TextField()
    plant_how_to_diseases = models.TextField()

    def __str__(self) -> str:
        return self.plant_name


# Soil model
class Soil(models.Model):
    # Account ID
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='soil', null=True)
    soil_type = models.ForeignKey(SoilType, on_delete=models.CASCADE, related_name='soil', null= True)

    def __str__(self) -> str:
        return str(self.user) +  "<->" + str(self.soil_type)

# User plant model
class Plant(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='plant')
    plant_type = models.ForeignKey(PlantType, on_delete=models.SET_NULL, related_name='plant', null=True)
    plant_current_size_height = models.DecimalField(max_digits=5, decimal_places=2, default=0)
    plant_current_size_spread = models.DecimalField(max_digits=5, decimal_places=2, default=0)
    planted_date = models.DateField()
    soil_planted = models.ForeignKey(Soil, on_delete=models.PROTECT, related_name='plant')
    image = models.ImageField(upload_to=get_image_path, blank=True, null=True)

    # Model Save override to save the image file with the id of the plant
    def save(self, *args, **kwargs):
        if self.id is None:
            saved_image = self.image
            self.image = None
            super(Plant, self).save(*args, **kwargs)
            self.image = saved_image
            if 'force_insert' in kwargs:
                del kwargs['force_insert']
            
        super(Plant, self).save(*args, **kwargs)
        
    ## planted_soil - create a relation between soiltype and plant

    def __str__(self) -> str:
        return self.plant_type.plant_name
