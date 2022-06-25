from django.shortcuts import HttpResponse, render
from rest_framework.response import Response
from rest_framework.permissions import AllowAny
from rest_framework.decorators import api_view, permission_classes

# Create your views here.

# Adding the welcome function to alter the views and route them to url in build_my_garden_backend
@api_view(['GET'])
@permission_classes([AllowAny],)
def IBM_Garden_Welcome(request):
    print("Request receieved!")
    return Response({'message:Request successfully returned! Hello Django'}, status=200)