from django.shortcuts import render
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status, generics
from .models import Listing, SellerAddress, ListingImage
from django.db.models import Prefetch
from .serializers import ListingSerializer
from geopy.geocoders import GoogleV3
from decouple import config

# Create the class to use for geolocation
geolocator = GoogleV3(api_key=config("GOOGLE_API_KEY"))

# Create your views here.
# API endpoint for listing
class ListingView(APIView):
    serializer_class = ListingSerializer
    
    def get(self, request: Request):
        '''
        Fetchs any listing found in a city
        '''
        city = request.query_params.get("city")
        latitude = request.query_params.get("latitude")
        longitude = request.query_params.get("longitude")
        
        # Get city using current location
        # used geopy doc: https://geopy.readthedocs.io/en/stable/#googlev3
        if latitude and longitude:
            location = geolocator.reverse(query=(latitude, longitude))
            address_components = location.raw['address_components']
            cities = [addr['long_name'] for addr in address_components if 'locality' in addr['types']]
            
            city = cities[0]

        if city:
            addresses = SellerAddress.objects.filter(city=city)
            listings = set()
            for address in addresses:
                listings = listings.union(address.listing.all())

            serializer = ListingSerializer(listings, many=True)

            return Response(serializer.data, status=status.HTTP_200_OK)
        else:
            return Response({'No Listing': 'Not Listing found around area. Be the first to list'}, 
            status=status.HTTP_404_NOT_FOUND)
        

    def post(self, request: Request):
        pass

# class ListingView(generics.ListAPIView):
#     address = SellerAddress.objects.filter(city="Sioux Falls")
#     queryset = address[0].listing.all() | address[1].listing.all()
#     serializer_class = ListingSerializer