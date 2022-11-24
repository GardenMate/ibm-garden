from os import stat
from urllib.request import Request
from requests import request
from django.http import JsonResponse, QueryDict
from rest_framework.views import APIView
from rest_framework.response import Response
# from build_my_garden_backend.main.models import PlantType
from main.models import Plant, Soil, PlantType
from .serializers import PlantGETSerializer, PlantSerializer, SoilSerializer, PlantTypeSerializer
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.parsers import FileUploadParser, MultiPartParser, FormParser
from rest_framework.request import Request
from django.db.models import Q
from ibm_watson import LanguageTranslatorV3
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator
import json


class WatsonView(APIView):
    def post(self, request:Request):

        print(request.data.get('info'))
        apikey = 'xr-JuhLUlEGfW2e7ZqBQZV6FPX7B3chHpAhVMaJHXvfb'
        url = 'https://api.us-south.language-translator.watson.cloud.ibm.com/instances/e73e1236-9397-4324-8003-d183779188ae'
        authenticator = IAMAuthenticator(f'{apikey}')
        language_translator = LanguageTranslatorV3(
        version='2018-05-01',
        authenticator=authenticator
        )

        print(request)
        language_translator.set_service_url(f'{url}')
        spanish_list = []
        for x in eval(request.data.get('info')):
            print(x)
            translation = language_translator.translate(text=x, model_id="en-es").get_result()
            spanish_list.append(translation['translations'][0]['translation'])

        
        return Response({"info":spanish_list}, status=status.HTTP_200_OK)

# Create your views here.
class PlantViews(APIView):
    """
    Post paramters to your Plant API
    """
    permission_classes = [IsAuthenticated]
    serializer_class = PlantSerializer

    # Post function
    def post(self, request,format=None):
        print(request.data)
        # request.data['user'] = request.user.id
        request_data = QueryDict(mutable=True)
        request_data.update(request.data)
        request_data.update({"user": request.user.id})
        soil = request.user.soil.all()
        soil = soil.first()
        
        request_data.update({'soil_planted': soil.id})
        print(request_data)
        serializer = PlantSerializer(data=request_data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # GET function
    def get(self,request,format = None):
        request_user = request.user
        """
        Return all the plants of the user
        """
        plants = Plant.objects.filter(user=request_user)
        serializer = PlantGETSerializer(plants,many=True)
        return Response(serializer.data)

# Creating a GET request for the Soil Model
class SoilViews(APIView):
    permission_classes = [IsAuthenticated]
    serializer_class = PlantSerializer

    # Post Function
    def post(self,request,format=None):
        '''
        Make a soil association for user
        '''
        request_data = QueryDict(mutable=True)
        request_data.update({'soil_type': 1})
        request_data.update({"user": request.user.id})

        serialzer = SoilSerializer(data = request_data)
        if serialzer.is_valid():
            serialzer.save()
            return Response(serialzer.data,status=status.HTTP_201_CREATED)
        return Response(serialzer.errors,status=status.HTTP_400_BAD_REQUEST)

    # GET function
    def get(self,request,format=None):
        request_user = request.user
        """
        Return all the soils of the user
        """
        soils = Soil.objects.filter(account_id = request_user)
        serializer = SoilSerializer(soils,many=True)
        return Response(serializer.data)

# POST to the Plant Type API
class PlantTypeViews(APIView):
    # permission_classes = [IsAuthenticated]
    serializer_class = PlantTypeSerializer

    # POST function
    def post(self,request,format=None):
        serializer = PlantTypeSerializer(data=request.data, many = True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    # GET function
    def get(self,request,format=None):
        """
        Return all the plant types
        """
        plant_types = PlantType.objects.all()
        serializer = PlantTypeSerializer(plant_types,many=True)
        return Response(serializer.data)

class PlantTypeSearchView(APIView):
    """
    Search for a plant type by name
    """
    permission_classes = [IsAuthenticated]
    serializer_class = PlantTypeSerializer

    def get(self,request: Request,format=None):
        search = request.query_params.get('search')
        if search:
            plant_types = PlantType.objects.filter(Q(plant_name__icontains = search))
            serializer = PlantTypeSerializer(plant_types,many=True)
            
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(status=status.HTTP_400_BAD_REQUEST)

class PlantSearch(APIView):

    def get(self, request: Request):
        '''
        Fetchs search result for my garden plant
        '''
        search = request.query_params.get('search')
        if search:
            plants = Plant.objects.filter(Q(plant_type__plant_name__icontains=search) | Q(plant_type__plant_description__icontains = search))
            serializer = PlantGETSerializer(plants, many=True)

            return Response(serializer.data, status=status.HTTP_200_OK)


        return Response({'No search':'No search result'}, status=status.HTTP_200_OK)
