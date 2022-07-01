# Urls.py for the authentication app
from django.urls import path, include
from . import views

urlpatterns = [
    path('accounts', include('dj_rest_auth.urls')),
    path('registration/', include('dj_rest_auth.registration.urls')),
    path('account/', include('allauth.urls')),
]