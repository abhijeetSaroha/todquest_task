import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_1_app/user.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _selectedSource = 'Google';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add User',
          style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.redAccent.shade100, width: 0.4),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: const TextStyle(fontSize: 15),
                    hintText: 'example',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.purpleAccent),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    hintText: 'example@gmail.com',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.purpleAccent),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: DropdownButtonFormField<String>(
                    value: _selectedSource,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSource = newValue!;
                      });
                    },
                    items: [
                      'Facebook',
                      'Instagram',
                      'Organic',
                      'Friend',
                      'Google'
                    ].map((source) {
                      return DropdownMenuItem<String>(
                        value: source,
                        child: Text(
                          source,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
                    decoration: const InputDecoration(labelText: 'Source'),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newUser = User(_nameController.text,
                          _emailController.text, _selectedSource);
                      final usersBox = Hive.box<User>('users');
                      usersBox.add(newUser);
                      Navigator.of(context).pop();
                    }
                  },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(8.0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      fixedSize: MaterialStateProperty.all<Size>(
                          const Size(120.0, 35.0)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red)),
                  child: const Text(
                    'Add User',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
