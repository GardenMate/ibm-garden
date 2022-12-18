import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:build_my_garden/service/base_url_service.dart';
import 'dart:io';

class ChatSystem extends StatefulWidget {
  const ChatSystem({Key? key}) : super(key: key);

  @override
  State<ChatSystem> createState() => _ChatSystemState();
}

class _ChatSystemState extends State<ChatSystem> {
  final TextEditingController _controller = TextEditingController();
  // final channel =
  //     IOWebSocketChannel.connect("ws://127.0.0.1:8000/ws/chat/suser/");
  WebSocket? channel;

  // Connect to the websocket
  void connectToWebsocket() async{
    // Connect to the websocket
    channel = await WebSocket.connect("ws://10.0.2.2:8000/ws/chat/suser/");
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
    if (channel != null) {
      channel!.add(_controller.text);
    }
    // Reset the text field
    _controller.text = "";
  }

  void recieveMessage() {
    if (channel != null) {
      channel!.listen((message) {
        print(message);
      });
    }
  }
}
