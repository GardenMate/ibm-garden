from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
import views

urlpatterns = [
    path('payment/', views.PaymentView.as_view(), name="PaymentAPI"),
]

urlpatterns = format_suffix_patterns(urlpatterns)