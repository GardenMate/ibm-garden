from rest_framework import serializers

from accounts.models import User
from .models import Listing, ListingImage, SellerInfromation
from djmoney.contrib.django_rest_framework import MoneyField


# Serializes the ListingImage Model for uploaded images from user
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

class SingleListingGETSerializer(serializers.ModelSerializer):
    class Meta:
        model = Listing
        fields = '__all__'
        #depth = 1

    # The following is the seller's rating
    seller_rating = serializers.IntegerField(source='seller.seller_rating')
    # The following is the seller's username
    seller_username = serializers.CharField(source='seller.user.username')
    # The following is the seller's first name
    seller_first_name = serializers.CharField(source='seller.user.first_name')
    # The following is the seller's first name
    seller_last_name = serializers.CharField(source='seller.user.last_name')
    # The following is for the plant's type
    plant_type = serializers.CharField(source='plant_type.plant_name')
    # The following is for the location address
    city = serializers.CharField(source='location.city')
    # The following is for image
    image = ListingImageSerializer(many=True)

class ListingPOSTSerializer(serializers.ModelSerializer):
    price = MoneyField(max_digits=10, decimal_places=2)
    class Meta:
        model = Listing
        fields = '__all__' 

    def create(self, validated_data):
        '''
        Creates and return Listing after validation
        '''
        return Listing.objects.create(**validated_data)

class SellerInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = SellerInfromation
        fields = '__all__'
    # Maybe a need to combine first and last name
    # or should be done on flutter side
    username = serializers.CharField(source='user.username')
    first_name = serializers.CharField(source='user.first_name')
    last_name = serializers.CharField(source='user.last_name')
    city = serializers.CharField(source='address.first')
    # [To Do] Handle rating differently - change datamodel need to 
    # show how many people rated and calculate average

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["email","phone_number"]


class SellerInfoPOSTSerializer(serializers.ModelSerializer):
    class Meta:
        user = UserSerializer()
        model = SellerInfromation
        fields = '__all__'
    # Maybe a need to combine first and last name
    # or should be done on flutter side
    
    def create(self, validated_data):
        seller = SellerInfromation.objects.create(
            user = validated_data['user'],
            profile_picture = validated_data['profile_picture'],
            dashboard_image = validated_data['dashboard_image'],
        )

        return seller
    
