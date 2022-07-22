from django.db import models
from django.core.validators import MaxValueValidator, MinValueValidator
from location_field.models.plain import PlainLocationField
from djmoney.models.fields import MoneyField
from djmoney.models.validators import MinMoneyValidator
from accounts.models import User
from main.models import PlantType
import os

def get_listing_image_path(instance, filename):
    '''Used to get the id of the listing to save the image file'''
    return os.path.join("media","upload", str(instance.listing.id), filename)

def get_profile_image_path(instance, filename):
    '''Used to get the id of the listing to save the image file'''
    return os.path.join("media","upload", str(instance.id), filename)

# Model for the seller, includes additional information
class SellerInfromation(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='seller_info', null=True)
    seller_rating = models.DecimalField(max_digits=3, decimal_places=2, validators=[MinValueValidator(0), MaxValueValidator(5)])
    profile_picture = models.ImageField(upload_to = get_profile_image_path)
    dashboard_image = models.ImageField(upload_to = get_profile_image_path)

    # Model Save override to get the id for the get_image_path
    def save(self, *args, **kwargs):
        if self.id is None:
            saved_image = self.profile_picture
            saved_image_2 = self.dashboard_image
            self.image = None
            super(SellerInfromation, self).save(*args, **kwargs)
            self.profile_picture = saved_image
            self.dashboard_image = saved_image_2
            if 'force_insert' in kwargs:
                kwargs.pop('force_insert')

        super(SellerInfromation, self).save(*args, **kwargs)

    def __str__(self) -> str:
        return str(self.id)

class SellerAddress(models.Model):
    seller = models.ForeignKey(SellerInfromation, on_delete=models.CASCADE, related_name='address', null=False)
    street_address = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    country = models.CharField(max_length=255, blank=True)
    # django-location-field used for location https://django-location-field.readthedocs.io/en/latest/#
    location = PlainLocationField(based_fields=['street_address', 'city'], zoom=10)

    def __str__(self) -> str:
        return str(self.city)

# Model for the lisiting
class Listing(models.Model):
    ITEM = "Item"
    LBS = "lbs"
    OZ = "oz"
    KG = "kg"
    G = "g"
    ML = "ml"
    # The different type of measurement for users to choose from
    QUANTITY_CHOICES = [
        (ITEM, "Item"),
        (LBS, "lbs"),
        (OZ, "oz"),
        (KG, "kg"),
        (G, "g"),
        (ML, "ml")
    ]

    seller = models.ForeignKey(SellerInfromation, on_delete=models.CASCADE, related_name='listing', null=False)
    # Make the distance from interval to have metrics system such as mile and such
    # Use KM and depending on the metric system, later convert
    distance_from_location = models.DecimalField(max_digits=6, decimal_places=2)
    title = models.CharField(max_length=255)
    plant_type = models.ForeignKey(PlantType, on_delete=models.SET_NULL, related_name="listing", null= True)
    description = models.TextField()
    quantity = models.DecimalField(max_digits=7, decimal_places=2, validators=[MinValueValidator(0)])
    quantity_type = models.CharField(max_length=20, choices=QUANTITY_CHOICES, default=ITEM)
    # djmoney was used to set the moenyfield doc at https://github.com/django-money/django-money
    price = MoneyField(max_digits=14, decimal_places=2, default_currency='USD', validators=[MinMoneyValidator(0)])
    location = models.ForeignKey(SellerAddress, on_delete=models.CASCADE, related_name="listing", null= False)

    def __str__(self) -> str:
        return self.title


class ListingImage(models.Model):
    listing = models.ForeignKey(Listing, on_delete=models.CASCADE, related_name="image", null=False)
    image = models.ImageField(upload_to = get_listing_image_path)

    # Model Save override to get the id for the get_image_path
    def save(self, *args, **kwargs):
        if self.id is None:
            saved_image = self.image
            self.image = None
            super(ListingImage, self).save(*args, **kwargs)
            self.image = saved_image
            if 'force_insert' in kwargs:
                kwargs.pop('force_insert')

        super(ListingImage, self).save(*args, **kwargs)
    
    def __str__(self) -> str:
        return str(self.image)