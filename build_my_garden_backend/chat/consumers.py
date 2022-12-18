import json
from channels.db import database_sync_to_async
from channels.generic.websocket import AsyncWebsocketConsumer, WebsocketConsumer
from .models import ChatUserList, ChatList, Messages, TokenManager
from django.contrib.auth import get_user_model
from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync
from .models import ChatUserList, ChatList, Messages
from rest_framework.authtoken.models import Token

User = get_user_model()


class ChatConsumer(WebsocketConsumer):
    def connect(self):

        self.current_user = self.scope['user']
        other_user_name = self.scope['url_route']['kwargs']['username']
        self.other_user = User.objects.get(username=other_user_name)

        # Save the user to the chat user list
        self.save_user_list()

        current_token = str(Token.objects.get(user=self.current_user))
        other_token = str(Token.objects.get(user=self.other_user))

        print(type(current_token))
        print(other_token)

        higher_token = max(current_token, other_token)
        lower_token = min(current_token, other_token)

        # Todo : Check if the token is already in the database
        # Done
        token = higher_token + lower_token

        # Save the token to the token manager

        # Check if the token is already in the database
        if TokenManager.objects.filter(token=token).exists():
            # Get the token
            self.token = TokenManager.objects.get(token=token)
        else:
            token_manager = TokenManager.objects.create(
                token=token, main_user=self.current_user, other_user=self.other_user)
            token_manager.save()
            self.token = token_manager
            print("token saved")

        # Room name is the token that is being used
        self.room_name = "chat_" + str(self.token.id)

        print(self.room_name)
        print(self.scope['path'])

        # Join room group
        async_to_sync(self.channel_layer.group_add)(
            self.room_name,
            self.channel_name
        )

        # Get the previous messages
        messages = self.get_latest_messages()

        self.accept()

        # Send the messages to the user backwords
        for message in reversed(messages):
            self.send(text_data=json.dumps({
                'type': 'chat',
                'message': message.message_content
            }))

    def receive(self, text_data):
        text_data_json = json.loads(text_data)
        message = text_data_json['message']
        # Print the message and the user that sent it
        print(message + " from " + self.current_user.username)
        
        # Save the message to the database
        self.message_model = Messages.objects.create(
            reciever=self.other_user, sender=self.current_user, message_content=message, token=self.token)
        self.message_model.save()

        async_to_sync(self.channel_layer.group_send)(
            self.room_name,
            {
                'type': 'chat_message',
                'message': message
            }
        )

    def chat_message(self, event):
        message = event['message']
        

        self.send(text_data=json.dumps({
            'type': 'chat',
            'message': message
        }))

    def disconnect(self, close_code):
        print("disconnected")
        print(close_code)

    def save_user_list(self):
        # Save the user to the chat user list
        # Check if the user is already in the database
        if ChatUserList.objects.filter(main_user=self.current_user, other_user=self.other_user).exists():
            # Get the user
            pass
        else:
            chat_user_list = ChatUserList.objects.create(
                main_user=self.current_user, other_user=self.other_user)
            chat_user_list.save()

    # Get the latest 10 messages
    def get_latest_messages(self):
        messages = Messages.objects.filter(
            token=self.token).order_by('-id')[:10]
        return messages

    def get_messages(self):
        messages = Messages.objects.filter(token=self.token)
        return messages
