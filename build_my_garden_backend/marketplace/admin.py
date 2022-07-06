from django.contrib import admin
from .models import Listing, SellerInfromation, SellerAddress, ListingImage
# Register your models here.
admin.site.register(SellerInfromation)
admin.site.register(Listing)
admin.site.register(SellerAddress)
admin.site.register(ListingImage)