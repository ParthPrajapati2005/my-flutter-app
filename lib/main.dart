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

class Home extends StatefulWidget {
    const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey.shade900,
            appBar: AppBar(
                title: const Text(
                    'Add a new society',
                    style: TextStyle(
                        color: Colors.white
                        ),
                    ),

                    centerTitle: true,
                    elevation: 0.0,
                    backgroundColor: Colors.grey.shade700,
            ),

            body: Padding(
                padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Column(
                    children: <Widget> [
                        Text(
                            'YOUR SOCIETIES:',
                            style: TextStyle(
                                color: Colors.grey.shade300,
                            ),
                        ),
                    ],
                ),
            ),

            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.grey.shade300,
                onPressed: () => (),
                child: const Text('+',
                    style: TextStyle(fontSize: 25.0),
                ),
            ),
        );
    }
}