from datetime import datetime, date, time, timedelta
from django.conf import settings
from accounts.models import User
from braintreeAPI.models import Invoicing
import braintree

gateway = braintree.BraintreeGateway(
    braintree.Configuration(
        environment = settings.BT_ENVIRONMENT,
        merchant_id = settings.BT_MERCHANT_ID,
        public_key = settings.BT_PUBLIC_KEY,
        private_key = settings.BT_PRIVATE_KEY
    )
)

if settings.BT_ENVIRONMENT == "sandbox":
    bt_env = braintree.Environment.Sandbox
else:
    bt_env = braintree.Environment.Production

bt_config = braintree.Configuration.configure(
        bt_env,
        merchant_id=settings.BT_MERCHANT_ID,
        public_key=settings.BT_PUBLIC_KEY,
        private_key=settings.BT_PRIVATE_KEY,
    )

# Create BrainTree's functions
def generate_client_token():
    return gateway.client_token.generate()

def transact(options):
    return gateway.transaction.sale(options)

def find_transaction(id):
    return gateway.transaction.find(id)

'''
Manage the creation of a Braintree user account
'''
# Needs vetting
class BraintreeAccount:
    
    agent_account_id = None

    def __init__(self, user):
        
        self.user = user
        # Create Braintree account
        agent_account = gateway.customer.create({"email": self.user.email})  # [TODO] Check if username works
        self.agent_account_id = agent_account.customer.id
       
        # up used to save user id
        up = self.user
        up.agent_id = self.agent_account_id
        up.save()

'''
Manage Payments
'''
class BraintreePayment:
    
    def __init__(self, *args, **kwargs):

        self.user = kwargs.get("user")
        self.agent_id = kwargs.get("agent_id")
        self.token = kwargs.get("token")
        self.paymentMethodNonce = kwargs.get("paymentMethodNonce")
        self.amount = kwargs.get("amount")
        self.card_id = kwargs.get("card_id")
        self.description = kwargs.get("description")
        self.currency = kwargs.get("currency")
        self.set_default = kwargs.get("set_default")

    def create(self):

        payment_method = gateway.payment_method.create({
            "customer_id": self.agent_id,
            "payment_method_nonce": self.token,
            "options": {
                "make_default": True,
                "verify_card": True,
                "fail_on_duplicate_payment_method": True
            }
        })

        customer = gateway.customer.find(self.agent_id)
        temp_list = []

        result = transact({
            'amount':self.amount,
            "payment_method_nonce": self.paymentMethodNonce,
            'options': {
                'submit_for_settlement': True
            }
        })


        if result.is_success:   #  or result.transction removed due to error causing (may need to be added)
            return {
				"message": "Success",
				"tran_id": result.transaction.id
			}
        else:
            return {
                "message": ", ".join([ f'{x.code} - {x.message}' for x in result.errors.deep_errors]),
				"tran_id": "N/A"
            }

'''
Produces and returns a list of cards assigned to each user
'''

class BraintreeData:

    def __init__(self, user) -> None:
        self.user = user

    def invoices(self):
        
        # Get agent_id from user model
        agent_id = self.user.agent_id

        invoices = gateway.transaction.search(
            braintree.TransactionSearch.customer_id == agent_id
        )

        invoice_list = [
            [
                inv.id,
                inv.created_at.strftime('%d-%m-%y'),
                "Catagory",    # Check if it is catagory
                "inv.amount",
            ]
            for inv in invoices.items
        ]

        if not invoice_list:
            return None
            
        return invoice_list
