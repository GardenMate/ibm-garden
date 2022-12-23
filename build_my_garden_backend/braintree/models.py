from django.db import models
from accounts.models import User

# Model for Invoices
class Invoicing(models.Model):
    
    timestamp = models.DateTimeField(auto_now_add=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    transaction_id = models.CharField(max_length=100)
    amount = models.IntegerField()

    def __str__(self) -> str:
        return f'{self.user}'