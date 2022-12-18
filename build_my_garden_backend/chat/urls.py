# Import from the django.urls module the path function
from django.urls import path
# Import from the chat app the views module
from . import views

urlpatterns = [
    # connect the consumer to the path chat/
    path("<str:username>", views.chat),
]
