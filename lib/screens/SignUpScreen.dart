import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Color LabelColor = Colors.white.withOpacity(0.8);

  //one boll variable for obsecure function
  bool obsecure_text = true;
  //icon value
  IconData obsecure_icon = Icons.visibility;
  String selectedImagePath;
  String url;
  //strings for name etc
  String firstname;
  String lastname;
  String email;
  String phone;
  String password;
  //text controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  //for storing image file
  File _image;

  void getImageFromCamera()async{
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.black,
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                children: [
                  Center(child: AutoSizeText(
                    'Sign Up',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.8),
                    ),),),
                  Form(
                    autovalidate: false,
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                          GestureDetector(
                            onTap: getImageFromCamera,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: _image == null ? AssetImage('assets/images/NoUser.png'): FileImage(_image),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 16,
                                    child: Icon(Icons.camera_alt,color: Colors.black,),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.4,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  controller: _firstnameController,
                                  onChanged: (value){
                                    setState(() {
                                      firstname = value;
                                    });
                                  },
                                  onSaved: (value){
                                    setState(() {
                                      firstname = value;
                                    });
                                  },
                                  cursorColor: Colors.white,
                                  maxLines: 1,
                                  obscureText: false,
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.4,
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: Colors.white),
                                  controller: _lastnameController,
                                  onChanged: (value){
                                    setState(() {
                                      lastname = value;
                                    });
                                  },
                                  onSaved: (value){
                                    setState(() {
                                      lastname = value;
                                    });
                                  },
                                  cursorColor: Colors.white,
                                  maxLines: 1,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    labelStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                        width: 1,
                                      ),
                                    ),
                                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 14),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                          Container(
                            width: double.infinity,
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.white),
                              controller: _emailController,
                              onChanged: (value){
                                setState(() {
                                  email = value;
                                });
                              },
                              onSaved: (value){
                                setState(() {
                                  email = value;
                                });
                              },
                              cursorColor: Colors.white,
                              maxLines: 1,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                                suffixIcon: Icon(Icons.email,color: Colors.white,),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 1,
                                  ),
                                ),
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 14),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                          Container(
                            width: double.infinity,
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              controller: _passwordController,
                              onChanged: (value){
                                setState(() {
                                  password = value;
                                });
                              },
                              onSaved: (value){
                                setState(() {
                                  password = value;
                                });
                              },
                              cursorColor: Colors.white,
                              maxLines: 1,
                              obscureText: obsecure_text,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                                suffixIcon: GestureDetector(
                                  child: Icon(obsecure_icon,color: Colors.white,size: 20,),
                                  onTap: (){
                                    setState(() {
                                      obsecure_text = obsecure_text == true ? false : true;
                                      obsecure_icon = obsecure_icon == Icons.visibility ? Icons.visibility_off : Icons.visibility;
                                    });
                                  },
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 1,
                                  ),
                                ),
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 14),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                          Container(
                            width: double.infinity,
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.white),
                              controller: _phoneController,
                              onChanged: (value){
                                setState(() {
                                  phone = value;
                                });
                              },
                              onSaved: (value){
                                setState(() {
                                  phone = value;
                                });
                              },
                              cursorColor: Colors.white,
                              maxLines: 1,
                              maxLength: 10,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Phone',
                                labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                                suffixIcon: Icon(Icons.phone,color: Colors.white,),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 1,
                                  ),
                                ),
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 14),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //button to sign up
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  //Navigator.pushNamed(context, 'Bottom Nav');
                                },
                                child: Material(
                                  elevation: 5,
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(15),
                                  child: Padding(
                                    child: AutoSizeText('Sign Up',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),maxLines: 1,),
                                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.035,horizontal: MediaQuery.of(context).size.width*0.1),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Material(
                                  elevation: 5,
                                  color: Colors.green.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(15),
                                  child: Padding(
                                    child: AutoSizeText('Go back',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),maxLines: 1,),
                                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.035,horizontal: MediaQuery.of(context).size.width*0.1),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
