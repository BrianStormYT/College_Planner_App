//Programmed by Brian Leong
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coding_minds_application/course_page.dart';

class AddCoursePage extends StatefulWidget {
  const AddCoursePage({super.key});

  @override
  State<AddCoursePage> createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  var userID = FirebaseAuth.instance.currentUser?.uid;
  var categoryController = TextEditingController();
  var numberController = TextEditingController();
  var nameController = TextEditingController();
  var unitsController = TextEditingController();
  var snackBar = const SnackBar(content: Text("Not set"),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            AppBar(
              title: const Text("Add Courses"),
              backgroundColor: const Color.fromARGB(255, 23, 3, 85),
            ),
            //Course Category Field
            const Padding( //Padding can also be used to add margins/separation
              padding: EdgeInsets.all(10),
              child: Text("What is the category of the course?"),
            ),
            Container( //Container is where we set margins
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: categoryController,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ie. COMSC, ENGIN...',
                ),
              ),
            ),
            //Course Number Field
            const Text("What is the course number?"),
            Container( //Container is where we set margins
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: numberController,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ie. 123, 456...',
                ),
              ),
            ),
            //Course Name Field
            const Text("What is the course name?"),
            Container( //Container is where we set margins
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ie. Physics for Engineers A...',
                ),
              ),
            ),
            //Course Units Field
            const Text("How many units is the course?"),
            Container( //Container is where we set margins
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: unitsController,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ie. 3, 4, 5...',
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: 275,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 11, 114, 15))
                ),
                //Send data to Firebase database
                onPressed: (){
                  FirebaseDatabase.instance.ref("/User$userID/Courses").child("Course${DateTime.now().millisecondsSinceEpoch}").set(
                    {
                      "category": categoryController.text,
                      "number": numberController.text,
                      "name": nameController.text,
                      "units": unitsController.text,
                    }
                  ).then((value){
                      snackBar = const SnackBar(
                        content: Text(
                          "Successfully saved course info to database",
                          style: TextStyle(
                            color: Color.fromARGB(238, 7, 254, 118)
                            ),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      //Add one to the numberOfCourses
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CoursePage()));
                    })
                    .catchError((error){
                      snackBar = const SnackBar(
                        content: Text(
                          "ERROR in saving course info to database",
                          style: TextStyle(
                            color: Color.fromARGB(237, 254, 48, 7)
                          ),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                },
                child: const Text("Submit"),
              ),
            ),
          ],// <Widget>[]
        ),
      ),
    );
  }
}
