library presentation;

import 'package:flutter/material.dart';

/// A PostsView Page.
class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("posts_tab_name")), body: const Center(child: Text("PostsPage")));
  }
}
