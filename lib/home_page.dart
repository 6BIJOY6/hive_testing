// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  Box? _box;

  @override
  void initState() {
    super.initState();
    _box = Hive.box('myBox');
    _controller.text = _box?.get('savedText', defaultValue: '') ?? '';
  }

  void _saveText() {
    _box?.put('savedText', _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hive Example")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter text'),
            ),
            ElevatedButton(
              onPressed: _saveText,
              child: const Text('Save'),
            ),
            const SizedBox(height: 20),
            Text("Saved text: ${_controller.text}"),
          ],
        ),
      ),
    );
  }
}
