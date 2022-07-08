from dataclasses import field
from rest_framework import serializers
from .models import Listing, ListingImage

class ListingImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ListingImage
        fields = '__all__'

class ListingGETSerializer(serializers.ModelSerializer):
    class Meta:
        model = Listing
        fields = '__all__'
        #depth = 1

    # The following is the seller's rating
    seller_rating = serializers.IntegerField(source='seller.seller_rating')
    # The following is for the plant's type
    plant_type = serializers.CharField(source='plant_type.plant_name')
    # The following is for the location address
    address = serializers.CharField(source='location.street_address')
    # The following is for image
    image = serializers.CharField(source='image.first')

class ListingPOSTSerializer(serializers.ModelSerializer):
    class Meta:
        model = Listing
        fields = '__all__'

    def create(self, validated_data):
        '''
        Creates and return Listing after validation
        '''
        return Listing.objects.create(**validated_data)