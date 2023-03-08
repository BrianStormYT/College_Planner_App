//Programmed by Brian Leong
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_coding_minds_application/add_course.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://assist.org/');

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  var courses = [];
  var userID = FirebaseAuth.instance.currentUser?.uid;

  _CoursePageState(){
    FirebaseDatabase.instance.ref("/User$userID/Courses").get()
      .then((datasnapshot){
        //I NEED TO ITERATE ACROSS ALL CHILD ITEMS
        print(datasnapshot.value);
     });
      /*.catchError((error){
        print("Failed to load data");
        print(error);
      });*/
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: const Text("Add Courses"),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0)
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 23, 3, 85),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: const [
                Text("For transfers: Check out Assist.org to find which classes to register for"),
                Text("1. Select the college you are transferring from and the college you are transferring to"),
                Text("2. Find your major"),
                Text("3. Click on articulation agreement"),
                Text("4. Add courses to this app"),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            height: 50,
            width: 300,
            child: const ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.deepPurple),
              ),
              onPressed: _launchUrl,
              child: Text("Assist Transfer Agreements"),
            ),
          ),
          listCourses(courses),
          Container(
            margin: const EdgeInsets.all(10),
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCoursePage())),
              child: const Text("Add Course"),
            ),
          ),
        ],
      ),
    );
  }
}

Widget listCourses(var courseList){
    if (courseList.length == 0){
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text("You have no courses registered"),
        ),
      );
    }
    else{
      return ListView.builder(
        itemCount: courseList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CoursePage())),
              trailing: const Icon(
                Icons.cancel,
                color: Color.fromARGB(255, 215, 66, 11),),
              title: Text(courseList[index].name.uppercase + '-' + courseList[index].number
               + ': ' + courseList[index].name + '(' + courseList[index].units + 'units )'
              ),
            ),
          );
        }
    );
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

//void removeCourse()

//FirebaseAuth.instance.currentUser?.email