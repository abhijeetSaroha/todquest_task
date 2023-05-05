import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_1_app/add_user_screen.dart';
import 'package:task_1_app/list_user_screen.dart';
import 'package:task_1_app/theme/theme.dart';
import 'package:task_1_app/user.dart';
import 'package:task_1_app/user_adapter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User List App',
      initialRoute: '/list_users',
      theme: AppTheme.theme,
      routes: {
        '/list_users': (context) => ListUserScreen(),
        '/add_user': (context) => AddUserScreen(),
      },
    );
  }
}
