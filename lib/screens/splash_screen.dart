import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundify/AppFunctions/Auth.dart';
import 'package:soundify/Constants/Strings.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soundify/screens/CheckIfUserLoggedIn.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      Strings().Splash_Screen_Header,
                      style: GoogleFonts.montserrat(fontSize: 44,color: Colors.white,fontWeight: FontWeight.w500),
                      maxLines: 1,
                    ),
                    SizedBox(width: 10,),
                    Align(
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 10,
                      ),
                      alignment: Alignment.bottomRight,
                    ),
                  ],
                ),
              ),
              Align(
                child: Logo(context),
                alignment: Alignment.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40,vertical: MediaQuery.of(context).size.width*0.2),
                child: Align(
                  child: AutoSizeText(Strings().splash_screen_sub_text,
                    maxLines: 4,
                    maxFontSize: 20,
                    minFontSize: 10,
                    style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  alignment: Alignment.center,
                ),
              ),

            ],
          ),
      ),

    );
  }

  void start_timer ()
  {

      Timer(
        Duration(seconds: 4),
          (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RootUserLoggedIn()));
          }
      );


  }

  @override
  void initState() {
    super.initState();
    start_timer();

  }

  Widget Logo(BuildContext context)
  {
    return Image.asset('assets/images/soundifytrans.png',width: MediaQuery.of(context).size.width*0.6,);
  }

}
