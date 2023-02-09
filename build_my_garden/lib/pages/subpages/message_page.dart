import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:build_my_garden/service/base_url_service.dart';
import 'package:build_my_garden/service/auth_service.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../service/secure_storage.dart';

class ChatSystem extends StatefulWidget {
  const ChatSystem({Key? key}) : super(key: key);

  @override
  State<ChatSystem> createState() => _ChatSystemState();
}

class _ChatSystemState extends State<ChatSystem> {
  final TextEditingController _controller = TextEditingController();
  // final channel =
  //     IOWebSocketChannel.connect("ws://127.0.0.1:8000/ws/chat/suser/");
  WebSocketChannel? channel;

  // Connect to the websocket
  void connectToWebsocket() async {
    // Authenticate the user from auth service

    // Get the token from the secure storage
    String? token = await SecureStorage.getToken();

    // Connect to the websocket
    channel = WebSocketChannel.connect(
        Uri.parse("$baseUrlWebsocket/ws/chat/suser/?token=$token"));
  }

  void getUserName() async {
    // Get the username from the secure storage
    String? username = await SecureStorage.getUserName();
    // Send the username to the websocket
    print(username);
  }

  // call the connectToWebsocket function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat System"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            //Button to connect to the websocket
            ElevatedButton(
              onPressed: connectToWebsocket,
              child: const Text("Connect to websocket"),
            ),
            // SizedBox
            const SizedBox(
              height: 24,
            ),
            //Button to get the username
            ElevatedButton(
              onPressed: getUserName,
              child: const Text("Get user name"),
            ),
            // SizedBox
            const SizedBox(
              height: 24,
            ),
            StreamBuilder(
              stream: channel?.stream,
              builder: (context, snapshot) {
                print(snapshot.data);
                // The snapshot data is json encoded so we need to decode it to get the message
                return Text(snapshot.hasData
                    ? '${jsonDecode(snapshot.data.toString())['message']}'
                    : '');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    // Send the message to the websocket in json format
    if (channel != null) {
      channel!.sink.add(jsonEncode({"message": _controller.text}));
    }
    // Clear the text field
    _controller.clear();
  }

  void recieveMessage() {
    if (channel != null) {
      channel!.stream.listen((message) {
        print(message);
      });
    }
  }
}
