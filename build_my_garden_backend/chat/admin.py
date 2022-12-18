from django.contrib import admin
from .models import ChatUserList, Messages, ChatList, TokenManager
# Register your models here.

admin.site.register(ChatUserList)
admin.site.register(Messages)
admin.site.register(ChatList)
admin.site.register(TokenManager)
