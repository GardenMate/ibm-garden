from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from mygarden import views

urlpatterns = [
    path('',views.PlantViews.as_view(),name="Plant-API"),
]

urlpatterns = format_suffix_patterns(urlpatterns)