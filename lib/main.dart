//Programmed by Brian Leong
import 'package:flutter/material.dart';
//import 'package:flutter_coding_minds_application/add_course.dart';
import 'package:flutter_coding_minds_application/sign_up.dart';
import 'package:flutter_coding_minds_application/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue, //hmm, figure out how to change this
      ),
      home: const MyHomePage(title: 'College Planner'),
      //const AddCoursePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var snackBar = const SnackBar(content: Text("Not set"),);

  @override
  void dispose() { // Clean up the controller when the widget is removed from the widget tree.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0)
          ),
        ),
      ),
      body: Center(
        //Make a column for the entire HomePage
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded //Expanded is where we set flex
            (
              flex: 20,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text(
                      "Welcome :)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(243, 232, 152, 22),
                        fontSize: 30,
                      ), 
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text(
                      "Please enter your email and password to login or sign-up",
                      style: TextStyle(
                        color: Color.fromARGB(243, 232, 152, 22),
                        fontSize: 20,
                      ), 
                    ),
                  ),
                ],
              ),
            ),
            //Login Field
            Expanded //Expanded is where we set flex
            (
              flex: 40,
              child: Column(
                children: [
                  //Email Field
                  Container( //Container is where we set margins
                    margin: const EdgeInsets.all(10),
                    child: TextField(
                      controller: emailController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email Address',
                      ),
                    ),
                  ),
                  //Password Field
                  Container( //Container is where we set margins
                    margin: const EdgeInsets.only(left:10, right:10),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  //Forgot Password Button (Inactive)
                  Container(
                    margin: const EdgeInsets.only(bottom:20),
                    height: 40,
                    width: 200,
                    child: TextButton(
                      onPressed: (){},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color.fromARGB(217, 248, 8, 8),
                          fontStyle: FontStyle.italic,
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 20,
              child: Column(
                children: [
                //Login Button  
                  Container(
                    margin: const EdgeInsets.only(bottom:20),
                    height: 40,
                    width: 275,
                    child: ElevatedButton(
                      //Login the user with Firebase Authentication
                      onPressed: (){
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text, 
                          password: passwordController.text,
                        )
                        .then((value){
                          snackBar = const SnackBar(
                            content: Text(
                              "Successful Login!",
                              style: TextStyle(
                                color: Color.fromARGB(238, 7, 254, 118)
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPage()));
                        })
                        .catchError((error){
                          snackBar = const SnackBar(
                            content: Text(
                              "ERROR: User not found!",
                              style: TextStyle(
                                color: Color.fromARGB(237, 254, 48, 7)
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      },
                      child: const Text("Login"),
                    ),
                  ),
                //SignUp Button
                  SizedBox(
                    height: 40,
                    width: 275,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.green)
                      ),
                      //Sign up user with Firebase Authentication
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                      },
                      child: const Text("Sign Up"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
Firebase configuration file lib\firebase_options.dart generated successfully with the following Firebase apps:

Platform  Firebase App Id
web       1:835268026511:web:8f14184061f992115390fa
android   1:835268026511:android:7b1d8fcaf73703115390fa
ios       1:835268026511:ios:891527021fb67edb5390fa
macos     1:835268026511:ios:891527021fb67edb5390fa
*/