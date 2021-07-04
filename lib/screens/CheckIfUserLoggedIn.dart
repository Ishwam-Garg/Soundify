import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soundify/screens/BottomNavScreen.dart';
import 'package:soundify/screens/SignInScreen.dart';
import 'package:soundify/AppFunctions/Auth.dart';
import 'dart:async';
class RootUserLoggedIn extends StatelessWidget {

  User user;
  
  @override
  Widget build(BuildContext context) {
    //User is depreciated form of FirebaseUser
    return FutureBuilder<User>(
        future: getCurrentUser(),//FirebaseAuth.instance.currentUser() => FirebaseAuth.instance.currentUser
        builder: (BuildContext context, AsyncSnapshot<User> snapshot)
        {
          if(snapshot.hasData)
            {
              User user = snapshot.data;
              print(snapshot.data);
              return BottomNavScreen();
            }

          return SignIn();

        }
    );
  }
}
