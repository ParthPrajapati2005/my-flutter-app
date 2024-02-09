import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_app2/firebase_options.dart';

///This is the main function, It is called at the very start
void main() async{ 
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,    //Connect to firebase
    );
    runApp(const MyApp());  //The main app is run.
}

///This is the main app class. It is a stateless widget as there are no widget insider THIS class
///which is changed frequently
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override                                 //Override any inherited methods
  Widget build(BuildContext context) {      //Main build function
    return const MaterialApp(               //Return a MaterialApp
      home: Home()
    );
  }
}

///This is the class for the page when the user clicks on a society card to open it.
class OpenPage extends StatefulWidget {     
    final String societyName;                   //It takes 1 parameter, the name of the society
    const OpenPage(this.societyName, {super.key});

    @override
    State<OpenPage> createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(                                //Create a scafold app.
            backgroundColor: Colors.grey.shade900,
            appBar: AppBar(                             //Create appBar and style it
                title: Text(
                    widget.societyName,
                    style: const TextStyle(
                        color: Colors.white,    
                        fontFamily: 'ProtestStrike'     //Use font ProtestStike, declared in pubspec.yaml
                    ),
                ),
                centerTitle:true,                   
                backgroundColor: Colors.grey.shade700,
            ),

            body: Container(                            //Enclose all widgets in the body with a Container Widget
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 5), //Add some margin
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [     
                        TextField(                      //Create an input text field
                            style: const TextStyle(
                                fontFamily: 'ProtestStrike',
                                fontSize: 18
                            ),
                            decoration: InputDecoration(      //Style the input text field
                                filled: true,
                                hintText: 'Chat here...',
                                hintStyle: const TextStyle(
                                    fontFamily: 'ProtestStrike'
                                ),
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

///This is the class for the Home page of the app
class Home extends StatefulWidget {                 //This is the class which 
    const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    
    List<Widget> societyCards = [];                     //Create a list of societyCards

    late TextEditingController controller;              //Controllers for textInput in the AlertDialog
    late TextEditingController descriptionController;

    @override
    void initState(){                                   //Initialise controllers
        super.initState();
        controller = TextEditingController();
        descriptionController = TextEditingController();
    }

    @override
    void dispose(){                                     //Method to dispose the controllers.
        controller.dispose();
        descriptionController.dispose();
        super.dispose();
    }

    Widget createSocietyCard(name, description){       //Method which returns a Card Widget to create for a society. It takes the name and description as parameters
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
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontFamily: 'ProtestStrike'
                                    ),
                                ),
                            ),
                        Center(
                            child: Text(
                                '$description',
                                style: TextStyle(
                                    fontFamily: 'ProtestStrike',
                                    color: Colors.grey.shade200
                                ),
                            ) ,
                        )
                        ],
                    ),
                ),

                    ElevatedButton(             //Create a button in every card to open its own page.
                        onPressed: () {
                            Navigator.push(     //If OPEN button clicked, open its page and add to stack to retain pages opened in order
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OpenPage(name)   //Create instance of OpenPage class.
                                )
                            );
                        },
                        child: const Text(
                            'OPEN',
                            style: TextStyle(
                                fontFamily: 'ProtestStrike',
                                fontSize: 15,
                            ),
                            )
                    ),
              
                    const SizedBox(
                        height: 6,
                    )
                  ]
              ),
            ),
        );
    }

    Future openTextInput() => showDialog(       //This method opens the input dialog to ask for name and description of society
        context: context,
        builder: (context) => Center(
          child: Wrap(
            children: [
                    AlertDialog(                            //Create AlertDialog Widget
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
                                    societyCards.add(createSocietyCard(controller.text, descriptionController.text));   //If Submit button pressed, create new card instance, and add to societyCards list.
                                })
                            },
                            child: const Text('SUBMIT'),
                            )
                        ],
                    )
                ],
            ),
        )
    );

    @override
    Widget build(BuildContext context) {        //This is the first build method of the Home Page
        return Scaffold(    
            backgroundColor: Colors.grey.shade900,
            appBar: AppBar(                             //Create appBar and style it.
                title: const Text(
                    'Add a new society',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ProtestStrike'
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
                        ...societyCards,        //Load the societies in the societyList here

                    ],
                ),
            ),

            floatingActionButton: FloatingActionButton(     //Create a floating button in bottom left to be able to add a society
                backgroundColor: Colors.grey.shade300,
                onPressed: () => {
                    openTextInput()                         //Call openTextInput function. 
                },
                child: const Text('+',
                    style: TextStyle(fontSize: 25.0),
                ),
            ),
        );
    }
}