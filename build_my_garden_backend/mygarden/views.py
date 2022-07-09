from rest_framework.views import APIView
from rest_framework.response import Response
from main.models import Plant
from .serializers import PlantSerializer
from rest_framework import status
from rest_framework.permissions import IsAuthenticated


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