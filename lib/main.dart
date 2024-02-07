import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home()
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
          title: const Text('This is a test app'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade700,
        ),

      body: Container(
          color: Colors.amber,
          padding: const EdgeInsets.all(20), 
          margin: const EdgeInsets.all(20),
          child: const Text("Some text"),
        ),
      floatingActionButton: FloatingActionButton(
          child: const Text('button'),
          onPressed: () => (),
        ),
      );
  }
}