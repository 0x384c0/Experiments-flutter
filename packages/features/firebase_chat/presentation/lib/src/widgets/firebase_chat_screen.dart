import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class FirebaseChatScreen extends StatefulWidget {
  static const String route = '/chat';
  final firebase.User firebaseUser;

  const FirebaseChatScreen({super.key, required this.firebaseUser});

  @override
  State<FirebaseChatScreen> createState() => _FirebaseChatScreenState();
}

class _FirebaseChatScreenState extends State<FirebaseChatScreen> with WidgetsBindingObserver {
  final scrollController = ScrollController();
  final textEditingController = TextEditingController();

  @override
  void initState() {
    _initializeChat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ChatScreen')),
      body: _messagesStream == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder(
              stream: _messagesStream,
              builder: (context, snapshot) {
                return Chat(
                  messages: snapshot.data ?? [],
                  user: _user,
                  onSendPressed: _handleSendPressed,
                  theme: _getChatTheme(context),
                );
              },
            ),
    );
  }

  ChatTheme _getChatTheme(BuildContext context) {
    final theme = Theme.of(context);
    final messageBodyTextStyle = theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.onSecondary);
    return DefaultChatTheme(
      primaryColor: theme.colorScheme.primary,
      secondaryColor: theme.colorScheme.secondary,
      errorColor: theme.colorScheme.error,
      backgroundColor: theme.colorScheme.surface,
      inputBackgroundColor: theme.colorScheme.tertiary,
      inputTextColor: theme.colorScheme.onTertiary,
      inputTextCursorColor: theme.colorScheme.onTertiary,
      sentMessageBodyTextStyle: messageBodyTextStyle,
      receivedMessageBodyTextStyle: messageBodyTextStyle,
      sendButtonIcon: Icon(Icons.send, color: theme.colorScheme.onTertiary),
    );
  }

  late final types.User _user;
  late final types.Room _room;

  Stream<List<types.Message>>? _messagesStream;

  void _handleSendPressed(types.PartialText message) {
    try {
      FirebaseChatCore.instance.sendMessage(message, _room.id);
    } catch (e) {
      _print(e.toString());
    }
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
      setState(() {
        _messagesStream = FirebaseChatCore.instance.messages(_room);
      });
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
