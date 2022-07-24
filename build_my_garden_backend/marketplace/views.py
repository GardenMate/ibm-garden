import re
from urllib import response
from django.http import QueryDict
from django.shortcuts import render
from django.db.models import Q
from requests import request
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.exceptions import ParseError
from rest_framework import status
from rest_framework.parsers import FileUploadParser, MultiPartParser, FormParser
from .models import Listing, SellerAddress, ListingImage
from django.db.models import Prefetch
from .serializers import ListingGETSerializer, ListingImageSerializer, ListingPOSTSerializer, SellerAddressSerializer, SellerInfoPOSTSerializer, SellerInfoSerializer, SingleListingGETSerializer
from geopy.geocoders import GoogleV3
from decouple import config
from rest_framework.permissions import IsAuthenticated
from django.http import QueryDict

# Create the class to use for geolocation
geolocator = GoogleV3(api_key=config("GOOGLE_API_KEY"))

# Create your views here.
# API endpoint for listing
class ListingView(APIView):
    serializer_class = ListingGETSerializer

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
            # print(address_components)
            print(location.address)
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
        

class ListingSearchView(APIView):
    serializer_class = ListingGETSerializer

    def get(self, request: Request):
        '''
        Fetchs search result for listing
        '''
        print(request.query_params)
        search = request.query_params.get('search')
        if search:
            listings = Listing.objects.filter(Q(title__icontains=search) | Q(plant_type__plant_name__icontains=search) | Q(description__icontains = search))
            serializer = ListingGETSerializer(listings, many=True)

            return Response(serializer.data, status=status.HTTP_200_OK)


        return Response({'No search':'No search result'}, status=status.HTTP_200_OK)
    

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

        print('Test')
        serializer = ListingImageSerializer(data=request.data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)


class SellerInfoAPI(APIView):

    def get(self, request:Request):
        '''
        Fetch all the information of the seller
        '''
        # Get the seller id from the token authentication
        seller = request.user.seller_info.all()
        if seller.exists():
            # Save the seller model
            seller = seller.first()
            serializer = SellerInfoSerializer(seller)

            return Response(serializer.data, status=status.HTTP_200_OK)
        else:
            return Response({'no_seller':'User has no seller account'}, status=status.HTTP_404_NOT_FOUND)

    def post(self, request: Request):
        request.user.first_name = request.data.get('first_name')
        request.user.last_name = request.data.get('last_name')
        request.user.save()
        print(type(request.data))
        normal_request = {'profile_picture':request.data.get('profile_picture'), 'dashboard_image':request.data.get('dashboard_image'), 'user':request.user.id}
        request_data = QueryDict('',mutable=True)
        request_data.update(normal_request)
        print(request_data)
        serialzer = SellerInfoPOSTSerializer(data=request_data)
        if serialzer.is_valid():
            # user_serializer.is_valid()
            serialzer.save()
            return Response(serialzer.data, status=status.HTTP_201_CREATED)
        # return Response({}, status=status.HTTP_200_OK)
        return Response(serialzer.errors, status=status.HTTP_400_BAD_REQUEST)


class SellerListing(APIView):

    def get(self, request: Request):
        '''
        Fetch all the listing of the seller's
        '''
        # Get the seller id from the token authentication
        seller = request.user.seller_info.all()
        if seller.exists():
            # Save the seller model
            seller = seller.first()
            listing = Listing.objects.filter(seller=seller)
            serializer = ListingGETSerializer(listing, many=True)
            # If no listing, can display an error or show a different view
            return Response(serializer.data, status=status.HTTP_200_OK)
            
        else:
            return Response({'No Seller':'User has no seller account'}, status=status.HTTP_404_NOT_FOUND)


    # [TO DO - Done] Move the post from ListingView to here
    def post(self, request: Request):
        '''
        Adds a new listing for the user
        '''
        # Create a new QueryDictionary that is mutable
        request_data = QueryDict(mutable=True)
        request_data.update(request.data)
        
        # Get the seller id from user if exists
        seller = request.user.seller_info.all()
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
    
class SingleListing(APIView):
    serializer_class = ListingGETSerializer

    def get(self, request: Request):
        '''
        Get the detailed information of a single listing
        '''
        id = request.query_params.get('id')

        if id:
            listing = Listing.objects.filter(id=id)

            if listing.exists():
                serializer = SingleListingGETSerializer(listing.first())
                return Response(serializer.data, status=status.HTTP_200_OK)
            else:
                return Response({'No Listing':'Not Listing Existing'}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response({}, status=status.HTTP_400_BAD_REQUEST)


class SellerAddressAPI(APIView):
    serializer_class = SellerAddressSerializer

    def post(self, request: Request):
        '''
        POST the seller address information
        '''

        address = request.data.get("address")
        latitude = request.data.get("latitude")
        longitude = request.data.get("longitude")

        # Get the seller id from user if exists
        seller = request.user.seller_info.all()
        if seller.exists():
            seller = seller.first()

            if address:
                # Get city using current location
                # used geopy doc: https://geopy.readthedocs.io/en/stable/#googlev3
                if latitude and longitude:
                    location = geolocator.reverse(query=(latitude, longitude))
                    address_components = location.raw['address_components']
                    print(address_components)
                    cities = [addr['long_name'] for addr in address_components if 'locality' in addr['types']]
                    countries = [addr['long_name'] for addr in address_components if 'country' in addr['types']]
                    
                    street_address = location.address
                    city = cities[0]
                    country = countries[0]

                    request_data = QueryDict(mutable=True)
                    request_data.update({"street_address":street_address, "city": city, "country": country, "seller":seller.id})

                    serializer = SellerAddressSerializer(data=request_data)
                    if serializer.is_valid():
                        serializer.save()
                        return Response(serializer.data, status=status.HTTP_200_OK)
                    else:
                        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
            return Response({"No":"No"}, status=status.HTTP_400_BAD_REQUEST)
        return Response({}, status=status.HTTP_400_BAD_REQUEST)


                    


        request_data = QueryDict(mutable=True)
        request_data.update(request.data)
        
        # Get the seller id from user if exists
        seller = request.user.seller_info.all()
        if seller.exists():
            seller = seller.first()

            