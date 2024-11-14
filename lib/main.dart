import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  Box? _box;
  List<String> names = [];

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('myBox');
    setState(() {
      names = List<String>.from(_box?.get('namesList', defaultValue: []) ?? []);
    });
  }

  void _saveName() {
    names.add(_controller.text);
    _box?.put('namesList', names);
    setState(() {});
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Name Saver")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter name'),
            ),
            ElevatedButton(
              onPressed: _saveName,
              child: const Text('Save'),
            ),
            const SizedBox(height: 20),
            const Text("Saved Names:"),
            // ignore: unnecessary_to_list_in_spreads
            ...names.map((name) => Text(name)).toList(),
          ],
        ),
      ),
    );
  }
}
