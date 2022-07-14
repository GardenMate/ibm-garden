from django.urls import path

from .views import ImageAPI, ListingSearchView, ListingView, SellerInfoAPI, SellerListing

urlpatterns = [
    path("listing/", ListingView.as_view()),
    path("image/add/", ImageAPI.as_view()),
    path("seller/", SellerInfoAPI.as_view()),
    path("seller/listing/", SellerListing.as_view()),
    path("listing/search/", ListingSearchView.as_view()),
]