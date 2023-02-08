from rest_framework import serializers


class PaymentSerializer(serializers.Serializer):
    # Payment JSON fields
    token = serializers.CharField(max_length=100)
    card_id = serializers.CharField(max_length=100)
    paymentMethodNonce = serializers.CharField(max_length=36)
    description = serializers.CharField(max_length=255, required=False)
    currency = serializers.CharField(max_length=100)
    set_default = serializers.BooleanField(default=True)
    amount = serializers.DecimalField(max_digits=10, decimal_places=2)
