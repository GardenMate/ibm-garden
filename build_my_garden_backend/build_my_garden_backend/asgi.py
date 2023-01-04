"""
ASGI config for build_my_garden_backend project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/4.0/howto/deployment/asgi/
"""

import os

from channels.routing import ProtocolTypeRouter
# Imported from the channels.routing module the ProtocolTypeRouter function
from django.core.asgi import get_asgi_application
from channels.auth import AuthMiddlewareStack
from channels.routing import URLRouter
import chat.routing
# Import the AllowedHostsOriginValidator function from the channels.security module
from channels.security.websocket import AllowedHostsOriginValidator
from chat.middleware import TokenAuthMiddleware

os.environ.setdefault('DJANGO_SETTINGS_MODULE',
                      'build_my_garden_backend.settings')
# Intialize the Django ASGI application early to ensure that the AppRegistry is populated
# before importing code that may import ORM models.
django_asgi_app = get_asgi_application()


# Removed the AllowedHostsOriginValidator for testing purposes
application = ProtocolTypeRouter(
    {"http": django_asgi_app, "websocket":
        TokenAuthMiddleware(
            URLRouter(
                chat.routing.websocket_urlpatterns
            )
        )
     })
