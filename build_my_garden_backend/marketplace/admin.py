from typing import List
from django.contrib import admin
from .models import Listing, SellerInfromation
# Register your models here.
admin.register(SellerInfromation)
admin.register(Listing)