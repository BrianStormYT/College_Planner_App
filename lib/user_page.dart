//Programmed by Brian Leong
import 'package:flutter/material.dart';
import 'package:flutter_coding_minds_application/course_page.dart';
import 'package:flutter_coding_minds_application/job_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0)
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 54, 98),
      ),
      body: ListView(
        children: <Widget>[
          //Active
          Card(
            child: ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CoursePage())),
              leading: const Icon(
                Icons.school,
                color: Color.fromARGB(255, 23, 3, 85),
              ),
              title: const Text('Course Planning'),
            ),
          ),
          //Inactive
          Card(
            child: ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const JobPage())),
              leading: const Icon(
                Icons.work,
                color: Color.fromARGB(255, 176, 33, 8),
              ),
              title: const Text('Jobs and Internships'),
            ),
          ),
          //Inactive 
          const Card(
            child: ListTile(
              leading: Icon(
                Icons.monetization_on,
                color: Color.fromARGB(255, 4, 107, 37),
              ),
              title: Text('Scholarships'),
            ),
          ),
          //Inactive
          const Card(
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: Color.fromARGB(255, 66, 63, 56),
              ),
              title: Text('User Settings'),
            ),
          ),
        ],
      ),
    );
  }
}