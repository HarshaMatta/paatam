import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Paatam Settings'),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 1, // Adjust the number of columns here
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 4,
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.amber[600],
                height: 10,
                child: const Center(child: Text('Item 1')),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.amber[600],
                height: 10,
                child: const Center(child: Text('Item 2')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
