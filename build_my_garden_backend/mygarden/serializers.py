from main.models import Plant
from rest_framework import serializers

class PlantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Plant
        fields = ["user","plant_type","plant_current_size_height","plant_current_size_spread","planted_date",]

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