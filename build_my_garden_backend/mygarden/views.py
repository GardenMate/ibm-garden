from urllib.request import Request
from requests import request
from django.http import QueryDict
from rest_framework.views import APIView
from rest_framework.response import Response
# from build_my_garden_backend.main.models import PlantType
from main.models import Plant, Soil, PlantType
from .serializers import PlantSerializer, SoilSerializer, PlantTypeSerializer
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.parsers import FileUploadParser, MultiPartParser, FormParser
from rest_framework.request import Request
from django.db.models import Q


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
        serializer = PlantSerializer(plants,many=True)
        return Response(serializer.data)

# Creating a GET request for the Soil Model
class SoilViews(APIView):
    permission_classes = [IsAuthenticated]
    serializer_class = PlantSerializer

    # Post Function
    def post(self,request,format=None):
        request.data['account_id'] = request.user.id
        serialzer = SoilSerializer(data = request.data)
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
            serializer = PlantSerializer(plants, many=True)

            return Response(serializer.data, status=status.HTTP_200_OK)


        return Response({'No search':'No search result'}, status=status.HTTP_200_OK)
