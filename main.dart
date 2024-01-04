// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_project/firebase_options.dart';
// import 'package:firebase_project/student_details.dart';
// import 'package:flutter/material.dart';
//
// void main() async{
//   print("okldhguodsgfv");
//
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a blue toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       // home: const MyHomePage(title: 'Flutter Demo Home Page'),
//       home: const StudentsDetails(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/carousel_slider.dart';
import 'package:firebase_project/chat.dart';
import 'package:firebase_project/chat_screen%20(1).dart';
import 'package:firebase_project/firebase_options.dart';
import 'package:firebase_project/student_details.dart';
import 'package:firebase_project/task_login.dart';
import 'package:firebase_project/willpop_scop.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized

  print("Initializing Firebase");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Firebase Initialized");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("Building MyApp widget");

    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const StudentsDetails(),
      // home: const ChatDemo(),
      // home: const MyScreen(),
      home: const TaskLoginPage(),
      // home: const WillScopDemo(),
      // home: const CarouselSliderDemo(),
    );
  }
}

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("-=--==-=-=-333");
    Future.delayed(Duration(seconds: 3), () {
      print("-=--==-=-=-44");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
              receiverId: "Raj",
              name: "Raj",
              senderId: "Jay"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: CircleAvatar(
            radius: 10,
            child: Image.asset(
              ".idea/assets/image/IMG_20230522_222325_233.jpg",
            ),
          ),
          centerTitle: true,
          actions: const [
            Icon(
              Icons.search_rounded,
              color: Colors.white,
            )
          ],
          title: const Text(
            // textAlign: TextAlign.center,
            "App Bar",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TabBar(
              unselectedLabelColor: Colors.black12,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text("Chat"),
                ),
                Tab(
                  child: Text("Popular"),
                ),
                Tab(
                  child: Text("Recent"),
                ),
                Tab(
                  child: Text("Update"),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(
                    child: Container(
                      // margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 80,
                      width: double.infinity,

                      child: InkWell(
                        onTap: () {
                          print("-=--==-=-=-11");
                          Future.delayed(Duration(seconds: 3), () {
                            print("-=--==-=-=-22");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    receiverId: "Raj",
                                    name: "Raj",
                                    senderId: "Jay"),
                              ),
                            );
                          });
                        },
                        child: Text("Raj", style: TextStyle(fontSize: 30)),
                      ),
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                  receiverId: "Jay",
                                  name: "Jay",
                                  senderId: "Raj"),
                            ));
                      },
                      child: Container(
                        color: Colors.cyan,
                      ),
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                  receiverId: "Sonu",
                                  name: "Sonu",
                                  senderId: "Yash"),
                            ));
                      },
                      child: Container(
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                  receiverId: "Yash",
                                  name: "Yash",
                                  senderId: "Sonu"),
                            ));
                      },
                      child: Container(
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //
            //     },
            //     child: Text("Raj")),
            // ElevatedButton(onPressed: () {
            //
            // }, child: Text("Jay"),),
            // ElevatedButton(
            //     onPressed: () {
            //
            //     },
            //     child: Text("Sonu"),),
            // ElevatedButton(
            //     onPressed: () {
            //
            //     },
            //     child: Text("Yash"),),
          ],
        ),
      ),
    );
  }
}
