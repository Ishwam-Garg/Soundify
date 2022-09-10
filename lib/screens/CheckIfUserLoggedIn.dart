import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soundify/screens/BottomNavScreen.dart';
import 'package:soundify/screens/SignInScreen.dart';

class RootUserLoggedIn extends StatefulWidget {

  @override
  State<RootUserLoggedIn> createState() => _RootUserLoggedInState();
}

class _RootUserLoggedInState extends State<RootUserLoggedIn> {
  User user;

  void load(BuildContext context) async{
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if(user==null)
      {
        print("User not found");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (cxt)=>SignIn()));
      }
      else
      {
        print("User found");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (cxt)=>BottomNavScreen()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    load(context);
    return Container(
      height: 40,
      width: 40,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
