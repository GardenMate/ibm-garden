from django.db import models
from django.contrib.auth import get_user_model
from chat.managers import ThreadManager
from django.utils import timezone


# Create your models here.

User = get_user_model()


class ChatUserList(models.Model):
    # Keep track of the users that our users are chatting with
    main_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="current_user", null=True)
    other_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="chat_user", null=True)
    # The user that is chatting with main_user

    def __str__(self):
        return f"{self.main_user} is chatting with {self.other_user}"

class TrackingModel(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True

class Thread(TrackingModel):
    THREAD_TYPE = (
        ('personal', 'Personal'),
        ('group', 'Group')
    )

    name = models.CharField(max_length=50, null=True, blank=True)
    thread_type = models.CharField(max_length=15, choices=THREAD_TYPE, default='group')
    users = models.ManyToManyField(User, related_name='threads')

    objects = ThreadManager()

    def __str__(self) -> str:
        if self.thread_type == 'personal' and self.users.count() == 2:
            return f'{self.users.first()} and {self.users.last()}'
        return f'{self.name}'


class Messages(TrackingModel):
    thread = models.ForeignKey(Thread, on_delete=models.CASCADE, null = True)
    sender = models.ForeignKey(User, on_delete=models.CASCADE)
    text = models.TextField(blank=False, null=True)
    timestamp = models.DateTimeField(default=timezone.now)

    def __str__(self) -> str:
        return f'From <Thread - {self.thread}>'

