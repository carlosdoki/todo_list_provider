import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/auth/todo_auth_provider.dart';
import '../../../core/ui/theme_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Selector<ToDoAuthProvider, String>(
          selector: (context, authProvider) =>
              authProvider.user?.displayName ?? 'Não',
          builder: (_, value, __) {
            return Text(
              'E ai, $value !',
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            context.read<ToDoAuthProvider>().logout();
          },
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }
}
