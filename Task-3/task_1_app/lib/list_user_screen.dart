// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_1_app/user.dart';

class ListUserScreen extends StatefulWidget {
  @override
  _ListUserScreenState createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {
  late Box<User> usersBox;
  List<String> filterSources = [
    'All',
    'Facebook',
    'Instagram',
    'Organic',
    'Friend',
    'Google',
  ];
  String selectedSource = 'All';
  String searchText = '';

  @override
  void initState() {
    super.initState();
    usersBox = Hive.box<User>('users');
  }

  Future<void> _deleteUser(User user) async {
    await usersBox.delete(user.key);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List of Users',
          style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.redAccent.shade100, width: 0.4),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search by name or email...',
                  prefixIcon: Icon(Icons.search_sharp),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton(
                  value: selectedSource,
                  onChanged: (value) {
                    setState(() {
                      selectedSource = value!;
                    });
                  },
                  items: filterSources
                      .map((source) => DropdownMenuItem(
                            value: source,
                            child: Text(
                              source,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedSource = 'All';
                      searchText = '';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                  ),
                  child: const Text('Clear Filters'),
                ),
              ],
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: usersBox.listenable(),
                builder: (context, Box<User> box, _) {
                  List<User> users = box.values.toList();
                  if (selectedSource != 'All') {
                    users = users
                        .where((user) => user.source == selectedSource)
                        .toList();
                  }
                  if (searchText.isNotEmpty) {
                    users = users
                        .where((user) =>
                            user.name.contains(searchText) ||
                            user.email.contains(searchText))
                        .toList();
                  }
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return UserTile(
                        user: user,
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/edit-user',
                          arguments: user,
                        ),
                        onDelete: () => _deleteUser(user),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        splashColor: Colors.redAccent,
        onPressed: () {
          Navigator.of(context).pushNamed('/add_user');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const UserTile({
    required this.user,
    required this.onTap,
    required this.onDelete,
  });

  Color _getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getRandomColor(),
        child: Text(user.name[0]),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        onPressed: onDelete,
      ),
      onTap: onTap,
    );
  }
}
