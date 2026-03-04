import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

@RoutePage()
class FirebaseChatScreen extends StatefulWidget {
  final firebase.User firebaseUser;

  const FirebaseChatScreen({super.key, required this.firebaseUser});

  @override
  State<FirebaseChatScreen> createState() => _FirebaseChatScreenState();
}

class _FirebaseChatScreenState extends State<FirebaseChatScreen> with WidgetsBindingObserver {
  final scrollController = ScrollController();
  final textEditingController = TextEditingController();
  final _chatController = InMemoryChatController();

  @override
  void initState() {
    _initializeChat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ChatScreen')),
      body: Chat(
        chatController: _chatController,
        currentUserId: 'user1',
        onMessageSend: _handleSendPressed,
        resolveUser: (UserID id) async {
          return User(id: id, name: _user.firstName);
        },
      ),
    );
  }

  late final types.User _user;
  late final types.Room _room;

  void _handleSendPressed(String text) {
    FirebaseChatCore.instance.sendMessage(types.PartialText(text: text), _room.id);
    _chatController.insertMessage(
      TextMessage(
        id: '${Random().nextInt(1000) + 1}',
        authorId: _user.id,
        createdAt: DateTime.now().toUtc(),
        text: text,
      ),
    );
  }

  _initializeChat() async {
    try {
      _user = types.User(
        id: widget.firebaseUser.uid, // UID from Firebase Authentication
        firstName: 'Test First Name',
        lastName: 'Test Last Name',
      );
      final users = await FirebaseChatCore.instance.users().first;
      if (!users.map((user) => user.id).contains(_user.id)) {
        await FirebaseChatCore.instance.createUserInFirestore(_user);
      }

      final rooms = await FirebaseChatCore.instance.rooms().first;

      _print("rooms: ${rooms.length}");

      if (rooms.isEmpty) {
        _room = await FirebaseChatCore.instance.createGroupRoom(name: 'test_group', users: []);
      } else {
        _room = rooms.first;
      }
      final Iterable<types.Message> messages = await FirebaseChatCore.instance.messages(_room).first;
      _chatController.messages.addAll(messages.map((e) => Message.fromJson(e.toJson())));
    } catch (e) {
      _print(e.toString());
    }
  }

  _print(String message) {
    debugPrint("----- $message");
    if (mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
