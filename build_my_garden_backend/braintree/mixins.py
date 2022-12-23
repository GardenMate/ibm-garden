from datetime import datetime, date, time, timedelta
from django.conf import settings
from accounts.models import User
from braintree.models import Invoicing
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

