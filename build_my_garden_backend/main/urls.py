# Urls.py for the main app

from django.urls import path
from . import views


urlpatterns = [
    path('IBMWelcomeGarden', views.IBM_Garden_Welcome, name='IBMWelcomeGarden')
]