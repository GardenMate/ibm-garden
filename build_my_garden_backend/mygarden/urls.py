from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from mygarden import views

urlpatterns = [
    path('plant/',views.PlantViews.as_view(),name="Plant-API"),
    path('soil/', views.SoilViews.as_view(),name="Soil-API"),
    path('planttype/', views.PlantTypeViews.as_view(),name="PlantType-API"),
    path('planttype/search', views.PlantTypeSearchView.as_view(),name="PlantType-Search-API"),
]

urlpatterns = format_suffix_patterns(urlpatterns)