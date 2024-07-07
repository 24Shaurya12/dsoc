import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyUserInfoModel extends ChangeNotifier {
  late String userName;
  late String userEmail;
  late String userPassword;
  late int userPhoneNo;

  void login(String email, String password) async {
    this.userEmail = email;
    this.userPassword = password;

    SharedPreferences userInfo = await SharedPreferences.getInstance();
    print('2: ${userInfo.getString("${this.userEmail} name")} and ${userInfo.getInt("${this.userEmail} phoneNo")}');

    this.userName = userInfo.getString("${this.userEmail} name")!;
    this.userPhoneNo = userInfo.getInt("${this.userEmail} phoneNo")!;

    print('3: $userName and $userPhoneNo');

    notifyListeners();
  }

  void signUp(String userName, String email, String password, int phoneNo) {
    this.userName = userName;
    this.userEmail = email;
    this.userPassword = password;
    this.userPhoneNo = phoneNo;

    notifyListeners();
  }
}
