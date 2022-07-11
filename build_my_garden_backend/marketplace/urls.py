from django.urls import path

from .views import ImageAPI, ListingView

urlpatterns = [
    path("listing/", ListingView.as_view()),
    path("image/add", ImageAPI.as_view()),
]