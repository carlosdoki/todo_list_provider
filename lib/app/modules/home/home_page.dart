import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/auth/todo_auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('Logout'),
          onPressed: () {
            context.read<ToDoAuthProvider>().logout();
          },
        ),
      ),
    );
  }
}
