from django.db import models
from django.contrib.auth.models import User, AbstractUser
from django.core.validators import RegexValidator

# Create your models here.
# User model
class User(AbstractUser):
    email = models.EmailField(unique=True)
    phoneNumberRegex = RegexValidator(regex = r"^\+?1?\d{8,15}$")
    phone_number = models.CharField(validators= [phoneNumberRegex], max_length= 16, unique= False)
