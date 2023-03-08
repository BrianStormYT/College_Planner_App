//Programmed by Brian Leong
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

var snackBar = const SnackBar(content: Text("Not set"),);
var emailController = TextEditingController();
var fullNameController = TextEditingController();

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var passwordController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Please fill in the following fields"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        //Make a column for the entire HomePage
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Login Field
            Expanded //Expanded is where we set flex
            (
              flex: 40,
              child: Column(
                children: [
                  //Full Name Field
                  Container( //Container is where we set margins
                    margin: const EdgeInsets.all(10),
                    child: TextField(
                      controller: fullNameController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Full Name',
                      ),
                    ),
                  ),
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
                ],
              ),
            ),
            Expanded(
              flex: 20,
              child: Column(
                children: [
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
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text, 
                          password: passwordController.text,
                        )
                        .then((value){
                          snackBar = const SnackBar(
                            content: Text(
                              "Successful Sign Up! You may now login",
                              style: TextStyle(
                                color: Color.fromARGB(238, 7, 254, 118)
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          //Send name and email for storage to Firebase Database
                          snackBar = sendUserInfoToDataBase();
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                        })
                        .catchError((error){
                          snackBar = const SnackBar(
                            content: Text(
                              "ERROR: Invalid Password/Email!",
                              style: TextStyle(
                                color: Color.fromARGB(237, 254, 48, 7)
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
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

//Send name to database
SnackBar sendUserInfoToDataBase(){
  FirebaseDatabase.instance.ref("/").child("User${FirebaseAuth.instance.currentUser?.uid}").set(
  {
    "name": fullNameController.text,
    "email": emailController.text,
    "Courses": "null",
  })
    .then((value){
      snackBar = const SnackBar(
        content: Text(
          "Successfully saved user info to database",
            style: TextStyle(
              color: Color.fromARGB(238, 7, 254, 118)
            ),
        ),
      );
    })
    .catchError((error){
      snackBar = const SnackBar(
        content: Text(
          "ERROR in saving user info to database",
            style: TextStyle(
               color: Color.fromARGB(237, 254, 48, 7)
             ),
        ),
      );
    });
    return snackBar;
}