from django.urls import path

from .views import ImageAPI, ListingSearchView, ListingView, LocationAPI, SellerAddressAPI, SellerInfoAPI, SellerListing, SingleListing

urlpatterns = [
    path("listing/", ListingView.as_view()),
    path("image/add/", ImageAPI.as_view()),
    path("seller/", SellerInfoAPI.as_view()),
    path("seller/listing/", SellerListing.as_view()),
    path("seller/address/", SellerAddressAPI.as_view()),
    path("listing/search/", ListingSearchView.as_view()),
    path("listing/details/", SingleListing.as_view()),
    path("location/", LocationAPI.as_view()),
    
]