from django.contrib import admin
from .models import User
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin

# Register your models here.
# Registered the User model
@admin.register(User)
class UserAdmin(BaseUserAdmin):
    # Override the fieldset function to include phone number
    def get_fieldsets(self, request, obj):
        fs = super(UserAdmin, self).get_fieldsets(request, obj)
        fs[1][1]['fields'] = ('first_name', 'last_name', 'email', 'phone_number', 'agent_id')
        return fs

    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('username', 'email', 'phone_number', 'password1', 'password2'),
        }),
    ) 