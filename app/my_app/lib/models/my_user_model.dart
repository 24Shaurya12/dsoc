import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyUserInfoModel extends ChangeNotifier {
  late String userName;
  late String userEmail;
  late int userPhoneNo;

  final firestoreDB = FirebaseFirestore.instance;

  Future<void> login(String email, String password) async {
    userEmail = email;

    await firestoreDB.collection('Users').where('userEmail', isEqualTo: email).get().then((firestoreUserData) {
      userName = firestoreUserData.docs[0]['userName'] ?? 'No Username found';
      userPhoneNo = firestoreUserData.docs[0]['phoneNo'] ?? 'No Phone Number found';
    });

    notifyListeners();
  }

  Future<void> signUp(String name, String email, int phoneNo) async {
    userName = name;
    userEmail = email;
    // userPassword = password;
    userPhoneNo = phoneNo;
    notifyListeners();

    firestoreDB.collection('Users').add({
      'userName': name,
      'userEmail' : email,
      'phoneNo' : phoneNo,
    });
  }

  Future<void> logout() async {
    userName = 'No User logged in';
    userPhoneNo = 0;
    userEmail = 'No User logged in';

    final providerData = await FirebaseAuth.instance.currentUser?.providerData;
    for (final provider in providerData!) {
      if(provider.providerId == 'google.com') {
        await GoogleSignIn().signOut();
      }
    }
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
