import 'package:flutter/material.dart';
import 'package:my_app/my_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Uri devClubFacebook = Uri.parse('https://www.facebook.com/tech.iitd/');
    Uri devClubGoogle = Uri.parse('https://devclub.in/#/');
    Uri devClubLinkedIn = Uri.parse('https://www.linkedin.com/company/devclub-iit-delhi/?originalSubdomain=in');
    Uri devClubInstagram = Uri.parse('https://www.instagram.com/devclub_iitd/?hl=en');
    return Scaffold(
      // appBar: const MyAppBar(),
      backgroundColor: const Color.fromARGB(255, 16, 44, 87),
      body: Column(
        children: [
          const MyAppBar(),
          Container(padding: const EdgeInsets.all(45.0), child: const Image(image: AssetImage('assets/logo.png'))),
          const Text(textAlign: TextAlign.center,'Hello, Welcome!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
          const SizedBox(height: 20,),
          const Text('Welcome to DSOC 2024', textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
          const SizedBox(height: 50,),
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 218, 192, 163)),
              child: const Text('Login', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
              onPressed: () {
                Navigator.pushNamed(context, '/login_page');
              },
            ),
          ),
          const SizedBox(height: 30,),
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 218, 192, 163)),
              child: const Text('Sign Up', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
              onPressed: () {
                Navigator.pushNamed(context, '/registration_page');
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 5),
            child: Text('or via social media')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () async {
                  launchUrl(devClubFacebook);
                },
                  icon: const Icon(FontAwesomeIcons.facebookF, color: Color.fromARGB(255, 218, 192, 163),),
              ),
              IconButton(
                onPressed: () async {
                  launchUrl(devClubGoogle);
                },
                  icon: const Icon(FontAwesomeIcons.google, color: Color.fromARGB(255, 218, 192, 163),)
              ),
              IconButton(
                  onPressed: () async {
                    launchUrl(devClubInstagram);
                  },
                  icon: const Icon(FontAwesomeIcons.instagram, color: Color.fromARGB(255, 218, 192, 163),)
              ),
              IconButton(
                  onPressed: () async {
                    launchUrl(devClubLinkedIn);
                  },
                  icon: const Icon(FontAwesomeIcons.linkedinIn, color: Color.fromARGB(255, 218, 192, 163),)
              ),

            ],
          )
        ],
      ),
    );
  }
}