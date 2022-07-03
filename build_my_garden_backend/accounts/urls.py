# Urls.py for the authentication app
from django.urls import path, include

urlpatterns = [
    path('', include('dj_rest_auth.urls')),
]