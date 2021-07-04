import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundify/screens/BottomNavScreen.dart';
import 'package:soundify/AppFunctions/Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {


  //one boll variable for obsecure function
  bool obsecure_text = true;
  //icon value
  IconData obsecure_icon = Icons.visibility;

  String apple_icon_path = "assets/images/apple.png";
  String google_icon_path = "assets/images/google.png";
  String facebook_icon_path = "assets/images/facebook.png";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: Container(
            color: Colors.black,
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                  Center(child: AutoSizeText(
                    'Sign In',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.8),
                      //color: Color(0xff086623),
                    ),),),
                  Form(
                    autovalidate: false,
                    child: Container(
                      width: double.infinity,
                      //height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                          //email box
                          TextFormField(
                            //email
                            cursorColor: Colors.white,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                decoration: TextDecoration.none
                            ),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              suffixIcon: Icon(Icons.email,color: Colors.white,size: 20,),
                              labelStyle: TextStyle(fontSize: 22,color: Colors.white.withOpacity(0.8),fontWeight: FontWeight.bold,),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                              enabledBorder: OutlineInputBorder(
                                //borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color(0xff086623),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color(0xff086623)
                                ),
                                //borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                          //password box
                          TextFormField(
                            //password
                            cursorColor: Colors.white,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                decoration: TextDecoration.none
                            ),
                            obscureText: obsecure_text,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(fontSize: 22,color: Colors.white.withOpacity(0.8),fontWeight: FontWeight.bold),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                              //for eye icon to switch on/off obsecure text
                              suffixIcon: GestureDetector(
                                child: Icon(obsecure_icon,color: Colors.white,size: 20,),
                                onTap: (){
                                  setState(() {
                                    obsecure_text = obsecure_text == true ? false : true;
                                    obsecure_icon = obsecure_icon == Icons.visibility ? Icons.visibility_off : Icons.visibility;
                                  });
                                },
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color(0xff086623),
                                ),
                                //borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                //borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color(0xff086623),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _Sign_in_button(context),
                              _Forgot_Password_Button(),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: _Sign_Up_Button(context),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  AutoSizeText('More Ways to Log In',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){
                                  google_SignIn().then((user){
                                    if(user!=null)
                                      {
                                        CreateUserInFireStore("Google Mail");
                                        //CreateUserSearchIndexInFireStore();
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNavScreen()));
                                      }
                                    else
                                      {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text('Could not Sign In',style: TextStyle(color: Colors.white),)));
                                      }
                                  });

                              },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              child: Image.asset(google_icon_path,height: 30,width: 30,fit: BoxFit.fill,),
                            //Image.asset(image,height: 30,width: 30,fit: BoxFit.fill,),
                          ),
                        ),
                        _Login_With(apple_icon_path,context),
                        GestureDetector(
                          onTap: () async{
                            await handleLogin().whenComplete((){
                              CreateUserInFireStore("Facebook");
                              //CreateUserSearchIndexInFireStore();
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNavScreen()));
                            });

                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: Image.asset(facebook_icon_path,height: 30,width: 30,fit: BoxFit.fill,),
                            //Image.asset(image,height: 30,width: 30,fit: BoxFit.fill,),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
          ),
            ),
        ),
      ),
    );
  }

  CreateUserInFireStore(String LoginMode) async{
    User user = await auth.currentUser;
    DocumentReference ref = FirebaseFirestore.instance.collection("Users").doc(user.uid);


    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    List<String> splitList = user.displayName.split(' ');
    List<String> indexList = [];

    for(int i=0;i<splitList.length;i++)
    {
      for(int j=0;j<splitList[i].length + i;j++)
      {
        indexList.add(splitList[i].substring(0,j).toLowerCase());
      }
    }


    Map<String,String> UserData ={
      "Name": user.displayName,
      "uid": user.uid,
      "Photo_url": user.photoURL,
      "email": user.email,
      "phone": user.phoneNumber,
      "login_Date": formattedDate.toString(),
      "login_mode": LoginMode,
    };

    Map<String,List<String>> searchIndexData = {
      'searchIndex': indexList,
    };

    ref.collection("UserData").doc("information").set(UserData);
    ref.set(searchIndexData);
    }

  Future<bool> _onBackPressed ()
  {
    SystemNavigator.pop();
  }

  Widget _Sign_in_button(BuildContext context)
  {
    return GestureDetector(
      onTap: (){
        //Navigator.pushNamed(context, 'Bottom Nav');
      },
      child: Material(
        elevation: 5,
        color: Colors.green,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          child: AutoSizeText('Sign In',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),maxLines: 1,),
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.035,horizontal: MediaQuery.of(context).size.width*0.1),
        ),
      ),
    );
  }

  Widget _Login_With(String image,BuildContext context)
  {
    return GestureDetector(
      onTap: (){

      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 30,
        child: Image.asset(image,height: 30,width: 30,fit: BoxFit.fill,),
        //Image.asset(image,height: 30,width: 30,fit: BoxFit.fill,),
      ),
    );
  }
  
  Widget _Forgot_Password_Button()
  {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        child: Align(
          child: Text(
          'Forgot Password ?',
          style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),alignment: Alignment.centerRight,),
      ),
    );
  }

  Widget _Sign_Up_Button(BuildContext context)
  {
      return GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, 'Sign Up');
        },
        child: Material(
          elevation: 5,
          color: Colors.green,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            child: AutoSizeText('Sign Up Here',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),maxLines: 1,),
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.035,horizontal: MediaQuery.of(context).size.width*0.1),
          ),
        ),
      );
  }




}
