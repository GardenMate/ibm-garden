from django.db import models
from django.contrib.auth import get_user_model

# Create your models here.

User = get_user_model()


class ChatUserList(models.Model):
    # Keep track of the users that our users are chatting with
    main_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="current_user", null=True)
    other_user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="chat_user", null=True)
    # The user that is chatting with main_user

    def __str__(self):
        return f"{self.main_user} is chatting with {self.other_user}"


class TokenManager(models.Model):
    token = models.CharField(max_length=100, unique=True)
    main_user = models.ForeignKey(
        User, on_delete=models.CASCADE, null=True, related_name="main_user")
    other_user = models.ForeignKey(
        User, on_delete=models.CASCADE, null=True, related_name="other_user")
    # The user that is chatting with main_user

    def __str__(self) -> str:
        return self.main_user.username + " " + self.other_user.username


class Messages(models.Model):
    # Keep track of the messages that our users are sending

    reciever = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name="reciever", null=True)

    sender = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name="sender", null=True)
    # The user that is sending the message

    message_content = models.CharField(max_length=500)
    # The content of the message

    # Create a timestamp for the message
    timestamp = models.DateTimeField(auto_now_add=True)

    # token id
    token = models.ForeignKey(
        TokenManager, on_delete=models.CASCADE, null=True)

    def __str__(self):
        # Return the hour and the minute of the message
        return f"{self.sender} sent a message to {self.reciever} at {self.timestamp.hour}:{self.timestamp.minute}"

# Path: build_my_garden_backend\chat\serializers.py
# Compare this snippet from build_my_garden_backend\chat\routing.py:

class ChatList(models.Model):
    # Keep track of the chats that our users are having

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    # The user that is chatting with main_user

    chat_user_list = models.ManyToManyField(ChatUserList)
    # The list of users that are chatting with the main_user

    messages = models.ManyToManyField(Messages)
    # The list of messages that are being sent in the chat

    def __str__(self):
        return self.user.username

