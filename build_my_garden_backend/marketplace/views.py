import base64
from django.http import QueryDict
from django.shortcuts import render
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.exceptions import ParseError
from rest_framework import status
from rest_framework.parsers import FileUploadParser, MultiPartParser, FormParser
from .models import Listing, SellerAddress, ListingImage
from django.db.models import Prefetch
from .serializers import ListingGETSerializer, ListingImageSerializer, ListingPOSTSerializer
from geopy.geocoders import GoogleV3
from decouple import config
from rest_framework.permissions import IsAuthenticated

# Create the class to use for geolocation
geolocator = GoogleV3(api_key=config("GOOGLE_API_KEY"))

# Create your views here.
# API endpoint for listing
class ListingView(APIView):
    serializer_class = ListingPOSTSerializer

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

            serializer = ListingGETSerializer(listings, many=True)

            return Response(serializer.data, status=status.HTTP_200_OK)
        else:
            return Response({'No Listing': 'Not Listing found around area. Be the first to list'}, 
            status=status.HTTP_404_NOT_FOUND)
        

    def post(self, request: Request):
        '''
        Adds a new listing for the user
        '''
        # Create a new QueryDictionary that is mutable
        request_data = QueryDict(mutable=True)
        request_data.update(request.data)
        
        # Get the seller id from user if exists
        seller = request.user.seller_info.filter(id=1)
        if seller.exists():
            seller = seller.first()
            # Save the seller id into the request data
            request_data.update({"seller": seller.id})
            # Serialize and save
            self.serializer_class = ListingPOSTSerializer
            serializer = ListingPOSTSerializer(data=request_data)

            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            else:
                return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)
            
        return Response({"Seller does not exist"}, status=status.HTTP_400_BAD_REQUEST)

class ImageAPI(APIView):
    # serializer_class = ListingImageSerializer
    parser_classes = [MultiPartParser, FormParser]

    def post(self, request: Request):
        '''
        Upload listing image from the user
        '''        
        # request_data = QueryDict(mutable=True)
        # request_data.update(request.data)
        # # request_data.update({"listing": 7})
        # print(request_data)

        serializer = ListingImageSerializer(data=request.data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)

         