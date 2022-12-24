from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.conf import settings
from django.http import HttpResponse
import json
from braintreeAPI.models import Invoicing
from braintreeAPI import gateway, BraintreeData, BraintreePayment,BraintreeAccount, generate_client_token, transact, find_transaction

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
@login_required
def payment(request):

    if request.method == "POST":

        user = request.user
        token = request.POST.get('braintreeToken', None)
        card_id = request.POST.get('card_id', None)
        paymentMethodNonce = request.POST.get('paymentMethodNonce', None)
        description = request.POST.get("description", None)
        currency = request.POST.get("currency", None)
        set_default = request.POST.get("set_default", None)

        amount = request.POST.get('amount')

        ### Need agent id
        agent_id = user.agent_id

        if not agent_id:
            # Create a braintree account???
            BraintreeAccount(request.user)
        
        payment = BraintreePayment(
            user=user,
            agent_id=agent_id,
            token=token,
            card_id=card_id,
            amount=amount,
            description=description,
            currency=currency,
            set_default=set_default
        ).create()

        if payment["message"] == "Perfect":

            invoice = Invoicing(
                user = user,
                transaction_id = payment["tran_id"],
                amount = float(amount)
            )

            invoice.save()
            user = user

            return HttpResponse(
                json.dumps({"result": "okay"}),
                content_type="application/json"
            )
        
        else:
            return HttpResponse(
                json.dumps({"result": "error", "message":payment["message"]}),
                content_type="application/json"
            )
    else:
        return HttpResponse(
			json.dumps({"result": "error"}),
			content_type="application/json"
			)

