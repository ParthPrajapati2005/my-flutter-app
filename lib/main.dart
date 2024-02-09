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


class OpenPage extends StatefulWidget {
    final String societyName;
    const OpenPage(this.societyName, {super.key});

    @override
    State<OpenPage> createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.societyName),
            ),

            body: const Center(
                child: Text('Some Text')
            ),
        );
    }
}


class Home extends StatefulWidget {
    const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    
    List<Widget> societyCards = []; //List of society cards

    late TextEditingController controller;

    @override
    void initState(){
        super.initState();
        controller = TextEditingController();
    }

    @override
    void dispose(){
        controller.dispose();
        super.dispose();
    }

    Widget createSocietyCard(name){
        Navigator.of(context).pop();
        controller.clear();
        return Card(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget> [
                    Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                        
                        child: Text(
                            '$name',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey
                                ),
                            ),
                        ),
                    ),

                    ElevatedButton(
                        onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OpenPage(name)
                                )
                            );
                        },
                        child: const Text('OPEN')
                    ),
              
                    const SizedBox(
                        height: 6,
                    )
                  ]
              ),
            ),
        );
    }



    Future openTextInput() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Your Society Name'),
            content: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                    hintText: 'Enter your society name'
                ),
                controller: controller,
            ),
            actions: [
                TextButton(
                    onPressed:() => {
                        setState(() {
                            societyCards.add(createSocietyCard(controller.text));
                        })
                    },
                    child: const Text('SUBMIT'),
                )
            ],
        )
    );

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
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Column(
                    children: <Widget> [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Text(
                                  'YOUR SOCIETIES:',
                                  style: TextStyle(
                                      color: Colors.grey.shade300,
                                  ),
                                  textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: 6,
                        ),
                        ...societyCards,

                    ],
                ),
            ),

            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.grey.shade300,
                onPressed: () => {
                    openTextInput()
                },
                child: const Text('+',
                    style: TextStyle(fontSize: 25.0),
                ),
            ),
        );
    }
}