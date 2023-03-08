import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key});

  @override
  State<JobPage> createState() => _JobPageState();
}

final urls = <Uri>[
    //Uris have a bunch of components, so parse grabs each component field as needed
    Uri.parse("https://www.linkedin.com/"),
    Uri.parse("https://www.indeed.com/"),
    Uri.parse("https://joinhandshake.com/"),
  ];

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: const Text("Jobs and Internships"),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0)
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 176, 33, 8),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: 50,
            width: 200,
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 12, 22, 214)),
              ),
              onPressed: () {}, //_launchUrl,
              child: const Text(
                "LinkedIn",
                style: TextStyle(color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: 50,
            width: 200,
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 187, 235, 15)),
              ),
              onPressed: () {}, //_launchUrl,
              child: const Text("Handshake",
                style: TextStyle(color: Colors.black,),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: 50,
            width: 200,
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 16, 6, 126)),
              ),
              onPressed: () {}, //_launchUrl,
              child: const Text("Indeed",
                style: TextStyle(color: Colors.white,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
*/