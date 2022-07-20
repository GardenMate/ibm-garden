from django.contrib import admin
from .models import Plant, PlantType, Soil, SoilType, Season

# Register your models here.
admin.site.register(Plant)
admin.site.register(PlantType)
admin.site.register(Soil)
admin.site.register(SoilType)
admin.site.register(Season)
