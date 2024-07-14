import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyUserInfoModel extends ChangeNotifier {
  late String userName;
  late String userEmail;
  late String userPassword;
  late int userPhoneNo;

  Future<void> login(String email, String password) async {
    this.userEmail = email;
    this.userPassword = password;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        this.userName = user.displayName ?? 'No Username found';
        this.userPhoneNo = 1234;
      }
    });

    notifyListeners();
  }

  void signUp(String userName, String email, String password, int phoneNo) {
    this.userName = userName;
    this.userEmail = email;
    this.userPassword = password;
    this.userPhoneNo = phoneNo;

    notifyListeners();
  }

  Future<void> logout() async {
    this.userName = 'No User logged in';
    this.userPhoneNo = 0;
    this.userEmail = 'No User logged in';
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
