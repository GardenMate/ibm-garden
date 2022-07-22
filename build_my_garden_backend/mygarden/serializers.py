from accounts.models import User
from main.models import Plant, PlantType, Soil
from rest_framework import serializers


        
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["email","phone_number"]

class PlantTypeSerializer:
    class Meta:
        model = PlantType
        fields = ["plant_name","plant_type","plant_size_height","plant_size_spread","plant_max_size_time","plant_harvest_length","sun_exposer"]

class PlantSerializer(serializers.ModelSerializer):
    class Meta:
        user = UserSerializer()
        plant_type = PlantTypeSerializer()
        model = Plant
        fields = '__all__'

        def create(self, validated_data):
            # create Plant
            plant = Plant.objects.create(
                user = validated_data['user'],
                plant_type = validated_data['plant_type'],
                plant_current_size_height = validated_data['plant_current_size_height'],
                plant_current_size_spread = validated_data['plant_current_size_spread'],
                planted_data = validated_data['planted_date'],
            )

            return plant

class SoilSerializer(serializers.ModelSerializer):
    class Meta:
        model = Soil
        fields = "__all__"

    