import 'dart:convert';

import 'package:common_presentation/widgets/loading_overlay_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:widgets_modifiers/style/styling_widgets_modifiers.dart';

import '../navigation/navigator.dart';

class FirebaseAuthScreen extends StatefulWidget {
  const FirebaseAuthScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FirebaseAuthScreenState();
}

class _FirebaseAuthScreenState extends State<FirebaseAuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final _emailController = TextEditingController(text: 'test_email@example.com');
  late final FirebaseChatNavigator _navigator = Modular.get();
  var _isLoading = false;

  _showLoading() => setState(() {
        _isLoading = true;
      });

  _hideLoading() => setState(() {
        _isLoading = false;
      });

  @override
  void initState() {
    _initChat();
    super.initState();
  }

  _initChat() async {
    await Firebase.initializeApp(); // call in main.dart
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (!mounted) return;
      if (user == null) {
        _print('User is currently signed out!');
      } else {
        _print('User is signed in!');
      }
    });
    _refresh();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("FirebaseAuthScreen")),
        body: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'forms_email'),
                    validator: (value) {
                      if (value?.isEmpty == true) return 'forms_empty_field';
                      if (!_emailRegExp.hasMatch(value!)) return 'forms_invalid_field';
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: _createUser,
                    child: const Text('SignIn to Chat'),
                  ),
                ],
              ).padding(all: 8),
            ),
            LoadingOverlayView(isLoading: _isLoading),
          ],
        ),
      );

  _createUser() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isLoading) return;
    try {
      _showLoading();

      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _createPasswordFromEmail(_emailController.text), // Security risk
      );
      _print('createUser ${credential.user?.uid}');
      await _signInUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _print('The account already exists for that email.');
        await _signInUser();
      } else {
        _print(e.toString());
      }
    } catch (e) {
      _print(e.toString());
    } finally {
      _hideLoading();
    }
  }

  _createPasswordFromEmail(String email) => base64Encode(utf8.encode(email));

  _signInUser() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _createPasswordFromEmail(_emailController.text),
    );
    _print('signInUser ${credential.user?.uid}');
    _navigator.toFirebaseChat(credential.user!);
  }

  _print(String message) {
    debugPrint("----- $message");
    if (mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  late final _testEmail = 'test@example.com';

  Future<void> _refresh() async {
    try {
      setState(() => _isLoading = true);
      setState(() {
        _emailController.text = _testEmail;
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
