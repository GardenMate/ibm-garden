# Urls.py for the authentication app
from django.urls import path, include
from . import views


urlpatterns = [
    path('', include('dj_rest_auth.urls')),
    path('registration/', include('dj_rest_auth.registration.urls')),
]