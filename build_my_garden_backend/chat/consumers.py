import json
from channels.db import database_sync_to_async
from channels.generic.websocket import AsyncWebsocketConsumer
from .models import ChatUserList, Messages, TokenManager
from django.contrib.auth import get_user_model
from channels.layers import get_channel_layer
from asgiref.sync import sync_to_async
from rest_framework.authtoken.models import Token

User = get_user_model()

# TODO : Get the latest messages from the database and send them to the user


class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):

        self.current_user = self.scope['user']
        # If user is not authenticated, autehnticate the user
        other_user_name = self.scope['url_route']['kwargs']['username']
        self.other_user = await sync_to_async(User.objects.get)(username=other_user_name)

        print(self.current_user)

        if self.current_user.is_authenticated:
            self.accept()
            print("User is authenticated")
        else:
            try:
                # Get the token from the url
                print(self.scope)
                token = self.scope['url_route']['kwargs']['token']
                # Get the user from the token
                user = await sync_to_async(Token.objects.get)(key=token).user
                # Save the user to the scope
                self.scope['user'] = user
                # Close the old connections
            except Token.DoesNotExist:
                pass

        # Save the user to the chat user list
        await self.save_user_list()

        current_token = str(await sync_to_async(Token.objects.get)(user=self.current_user))
        other_token = str(await sync_to_async(Token.objects.get)(user=self.other_user))

        print(type(current_token))
        print(other_token)

        higher_token = max(current_token, other_token)
        lower_token = min(current_token, other_token)

        token = higher_token + lower_token

        # Save the token to the token manager

        # Check if the token is already in the database
        token_dummy_status = await self.check_token(token)
        if token_dummy_status:
            # Get the token
            self.token = await sync_to_async(TokenManager.objects.get)(token=token)
        else:
            token_manager = await sync_to_async(TokenManager.objects.create)(
                token=token, main_user=self.current_user, other_user=self.other_user)
            await self.save_token_manager(token_manager)
            self.token = token_manager
            print("token saved")

        # Room name is the token that is being used
        self.room_name = "chat_" + str(self.token.id)

        # Join room group
        await self.channel_layer.group_add(
            self.room_name,
            self.channel_name)

        # Get the previous messages
        await self.get_latest_messages()

        # Send the previous messages to the user
        # await self.send_messages(messages)

        await self.accept()

    async def receive(self, text_data):
        text_data_json = json.loads(text_data)
        message = text_data_json['message']

        # The message is being sent by the current user
        print(message)
        # Save the message to the database
        self.message_model = await sync_to_async(Messages.objects.create)(
            reciever=self.other_user, sender=self.current_user, message_content=message, token=self.token)
        await self.save_message_model(self.message_model)

        await self.channel_layer.group_send(
            self.room_name,
            {
                'type': 'chat_message',
                'message': message
            }
        )

    async def chat_message(self, event):
        message = event['message']

        await self.send(text_data=json.dumps({
            'type': 'chat',
            'message': message
        }))

    async def disconnect(self, close_code):
        print("disconnected")
        print(close_code)

    @database_sync_to_async
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
    @database_sync_to_async
    def get_latest_messages(self):
        messages = Messages.objects.filter(
            token=self.token).order_by('-id')[:10]

        async def send_messages(messages):
            for message in reversed(messages):
                await self.send_message_actual(message)

        send_messages(messages)

        return messages

    @database_sync_to_async
    def get_messages(self):
        messages = Messages.objects.filter(token=self.token)
        return messages

    # Check if the token exists
    @database_sync_to_async
    def check_token(self, token):
        token = TokenManager.objects.filter(token=token)
        return token.exists()

    # Save the tokenmanager
    @database_sync_to_async
    def save_token_manager(self, token_manager):
        token_manager.save()

    # Send the messages to the user backwords

    async def send_messages(self, messages):
        for message in reversed(messages):
            await self.send_message_actual(message)

    # Save message model
    @database_sync_to_async
    def save_message_model(self, message_model):
        message_model.save()

    # Actually send the previous messages to the chat room
    async def send_message_actual(self, message):
        await self.send(text_data=json.dumps({
            'type': 'chat',
            'message': message.message_content
        }))
