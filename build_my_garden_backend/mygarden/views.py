from rest_framework.views import APIView
from rest_framework.response import Response
from main.models import Plant, Soil
from .serializers import PlantSerializer, SoilSerializer, PlantTypeSerializer
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.parsers import FileUploadParser, MultiPartParser, FormParser


# Create your views here.
class PlantViews(APIView):
    """
    Post paramters to your Plant API
    """
    permission_classes = [IsAuthenticated]
    serializer_class = PlantSerializer

    # Post function
    def post(self, request,format=None):
        request.data['user'] = request.user.id
        serializer = PlantSerializer(data=request.data)
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