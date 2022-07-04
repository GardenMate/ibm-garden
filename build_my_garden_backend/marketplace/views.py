from django.shortcuts import render
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView
from .models import Listing

# Create your views here.
# API endpoint for listing
class ListingView(APIView):
    
    def get(self, request: Request):
        print(request.query_params)
        location = request.query_params.get("location")
        

    def post(self, request: Request):
        pass