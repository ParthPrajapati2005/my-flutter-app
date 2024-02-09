import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_app2/firebase_options.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );
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
            backgroundColor: Colors.grey.shade900,
            appBar: AppBar(
                title: Text(
                    'Society : ${widget.societyName}',
                    style: const TextStyle(
                        color: Colors.white
                    ),
                ),
                centerTitle:true,
                backgroundColor: Colors.grey.shade700,
            ),

            body: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                        TextField(
                            decoration: InputDecoration(
                                filled: true,
                                hintText: 'Chat here...',
                                fillColor: Colors.grey.shade600,
                                suffixIcon: IconButton(
                                    icon: const Icon(Icons.send),
                                    onPressed: (){},
                                )
                            ),
                            cursorColor: Colors.white,
                        )
                    ],
                ),
            )
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
    late TextEditingController descriptionController;

    @override
    void initState(){
        super.initState();
        controller = TextEditingController();
        descriptionController = TextEditingController();
    }

    @override
    void dispose(){
        controller.dispose();
        descriptionController.dispose();
        super.dispose();
    }

    Widget createSocietyCard(name, description){
        Navigator.of(context).pop();
        controller.clear();
        descriptionController.clear();
        return Card(
            color: Colors.grey,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget> [
                    Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                                '$name',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black
                                    ),
                                ),
                            ),
                        Center(
                            child: Text(
                                '$description'
                            ) ,
                        )
                      ],
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
        builder: (context) => Center(
          child: Wrap(
            children: [AlertDialog(
                title: const Text('Your Society Name'),
                content: Column(
                  children: [
                    TextField(
                        autofocus: true,
                        decoration: const InputDecoration(
                            hintText: 'Enter your society name'
                        ),
                        controller: controller,
                    ),
                    TextField(
                        autofocus: true,
                        decoration: const InputDecoration(
                            hintText: 'Enter your description'
                        ),
                        controller: descriptionController,
                    ),
                  ],
                ),
                actions: [
                    TextButton(
                        onPressed:() => {
                            setState(() {
                                societyCards.add(createSocietyCard(controller.text, descriptionController.text));
                            })
                        },
                        child: const Text('SUBMIT'),
                    )
                ],
            )],
          ),
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