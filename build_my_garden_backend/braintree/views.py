from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.conf import settings
from django.http import HttpResponse
import json
from braintree.models import Invoicing

# Create your views here.
