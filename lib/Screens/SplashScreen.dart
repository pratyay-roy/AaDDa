import 'dart:async';

import 'package:aadda/Model/UserModel.dart';
import 'package:aadda/Screens/LoginScreen.dart';
import 'package:aadda/Services/SessionManagement.dart';
import 'package:flutter/material.dart';

import 'UserListScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<UserModel> _currentUser;

  @override
  void initState() {
    super.initState();
    startCount();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _currentUser,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          // check for errors
          if (snapshot.hasError) return Text("ERROR");

          //when incomplete
          return Scaffold(
            body: Container(
              // color: AccentColour,
              child: Center(
                child: Image.asset("res/logos/AaDDa-logos_transparent.png"),
              ),
            ),
          );
        });
  }

  void startCount() async {
    UserModel user;
    bool isLoggedIn;
    SessionManagement.IsLoggedIn().then((value) {
      isLoggedIn = value;
      if (value == true) {
        SessionManagement.getUserData().then((map) {
          user = UserModel(
              userEmail: map[SessionManagement.USER_EMAIL_KEY],
              userName: map[SessionManagement.USER_NAME_KEY],
              userID: map[SessionManagement.USER_ID_KEY],
              userAbout: map[SessionManagement.USER_ABOUT_KEY],
              userPic: map[SessionManagement.USER_PIC_KEY]);
          print(
              "About ${map[SessionManagement.USER_ABOUT_KEY]}, ${map[SessionManagement.USER_EMAIL_KEY]}");
        });
      }
    }).catchError((onError) => print("SplashScreen " + onError.toString()));

    Timer(Duration(seconds: 5), () {
      if (isLoggedIn)
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UserListScreen(
                      currentUser: user,
                    )));
      else
        Navigator.pushReplacementNamed(context, LoginScreen.ID);
    });
  }
}
