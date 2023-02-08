from django.urls import re_path
from . import consumers

websocket_urlpatterns = [
    # re_path("ws/chat/", consumers.ChatConsumer.as_asgi()),
    re_path(r'^ws/chat/(?P<username>[^/]+)/',
            consumers.ChatConsumer.as_asgi()),
]
