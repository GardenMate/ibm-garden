from django.urls import path
from .views import ListingView

urlpatterns = [
    path("listing/", ListingView.as_view()),
]