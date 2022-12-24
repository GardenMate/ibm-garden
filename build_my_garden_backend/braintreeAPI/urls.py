from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from .views import PaymentView

urlpatterns = [
    path('payment/', PaymentView.as_view(), name="PaymentAPI"),
]

urlpatterns = format_suffix_patterns(urlpatterns)