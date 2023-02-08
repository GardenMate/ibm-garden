from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.conf import settings
from django.http import HttpResponse
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
import json
from .models import Invoicing
from .braintreeAPI import gateway, BraintreeData, BraintreePayment,BraintreeAccount, generate_client_token, transact, find_transaction
from .serializers import PaymentSerializer

# Create your views here.

'''
Cart view 
'''
@login_required
def cart(request):

    user = request.user
    agent_id = user.agent_id

    braintree_client_token = gateway.client_token.generate({"customer_id": agent_id})

    context = {
        "braintree_client_token": braintree_client_token
    }

    return render(request, 'api/cart.html', context=context)

'''
AJAX function to handle Braintree payment
'''
class PaymentView(APIView):
    permission_classes = [IsAuthenticated]
    serializer_class = PaymentSerializer

    def post(self, request):
        
        # Get request.data
        request_data = request.data

        user = request.user
        agent_id = user.agent_id

        token = request_data.get('braintreeToken', None)
        card_id = request_data.get('card_id', None)
        paymentMethodNonce = request_data.get('paymentMethodNonce', None)   # Need to be used instead of token
        description = request_data.get("description", None)
        currency = request_data.get("currency", None)
        set_default = request_data.get("set_default", None)
        amount = request_data.get('amount')
 

        if not agent_id:
            agent_id = BraintreeAccount(request.user).agent_account_id
        
        payment = BraintreePayment(
            user=user,
            agent_id=agent_id,
            paymentMethodNonce=paymentMethodNonce,    # Token may not be the correct value
            # card_id=card_id,
            amount=amount,
            description=description,
            currency=currency,
            set_default=set_default
        ).create()

        if payment["message"] == "Success":

            invoice = Invoicing(
                user = user,
                transaction_id = payment["tran_id"],
                amount = float(amount)
            )

            invoice.save()
            user = user

            return HttpResponse(
                json.dumps({"result": "Purchase Complete", "message": "Success"}),
                content_type="application/json"
            )
        
        else:
            return HttpResponse(
                json.dumps({"result": "error", "message":payment["message"]}),
                content_type="application/json"
            )
