import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/custom_classes/my_app_bar.dart';
import 'package:my_app/custom_classes/my_navigation_drawer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/internet_connectivity.dart';
import '../models/my_user_model.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Uri devClubFacebook = Uri.parse('https://www.facebook.com/tech.iitd/');
    Uri devClubGoogle = Uri.parse('https://devclub.in/#/');
    Uri devClubLinkedIn = Uri.parse(
        'https://www.linkedin.com/company/devclub-iit-delhi/?originalSubdomain=in');
    Uri devClubInstagram =
        Uri.parse('https://www.instagram.com/devclub_iitd/?hl=en');

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: const MyAppBar(
          backOption: false,
        ),
        endDrawer: const MyEndDrawer(),
        backgroundColor: const Color.fromARGB(255, 16, 44, 87),
        body: ListView(
          children: [
            Container(
                padding: const EdgeInsets.all(45.0),
                child: const Image(image: AssetImage('assets/logo.png'))),
            const Text(
                textAlign: TextAlign.center,
                'Hello, Welcome!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Welcome to DSOC 2024',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 30),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 218, 192, 163)
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login_page');
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 218, 192, 163)),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/registration_page');
                  },
                ),
              ),
            ),
            const Center(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 5),
                  child: Text('or via social media')),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async {
                    launchUrl(devClubFacebook);
                  },
                  icon: const Icon(
                    FontAwesomeIcons.facebookF,
                    color: Color.fromARGB(255, 218, 192, 163),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      if(await getConnectivity() == false) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('No Internet! Please connect to the Internet'),
                          duration: Duration(
                            milliseconds: 1500,
                          ),
                        ));
                      }
                      else {
                        try {
                          final UserCredential credentials = await signInWithGoogle();
                          Provider.of<MyUserInfoModel>(context, listen: false)
                              .signUp(
                              credentials.user?.displayName ?? 'No username',
                              credentials.user?.email ?? 'No email',
                              0);
                          Navigator.pushNamed(context, '/home_page');
                        } on Exception catch (e) {
                          print(e);
                        }
                      }
                    },
                    icon: const Icon(
                      FontAwesomeIcons.google,
                      color: Color.fromARGB(255, 218, 192, 163),
                    )),
                IconButton(
                    onPressed: () async {
                      launchUrl(devClubInstagram);
                    },
                    icon: const Icon(
                      FontAwesomeIcons.instagram,
                      color: Color.fromARGB(255, 218, 192, 163),
                    )),
                IconButton(
                    onPressed: () async {
                      launchUrl(devClubLinkedIn);
                    },
                    icon: const Icon(
                      FontAwesomeIcons.linkedinIn,
                      color: Color.fromARGB(255, 218, 192, 163),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {

  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}

