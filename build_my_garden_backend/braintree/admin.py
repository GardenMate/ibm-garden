from django.contrib import admin
from .models import Invoicing

# Register your models here.
class InvoicingAdmin(admin.ModelAdmin):

    list_display = ('id', 'user', 'timestamp')

admin.site.register(Invoicing, InvoicingAdmin)