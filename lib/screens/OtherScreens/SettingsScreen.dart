import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundify/Constants/Color_Pallete.dart';
import 'package:soundify/AppFunctions/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import '../SignInScreen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool switch1 = false;
  bool switch2 = false;
  bool _switch3 = false;
  bool switch4 = false;
  bool switch5 = false;bool switch6 = false;bool switch7 = false;bool switch8 = false;
  bool switch9 = false;bool switch10 = false;
  bool switch11 = false;bool switch12 = false;

  String image_url;
  String user_name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageUrl();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Settings',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
        centerTitle: true,
        backgroundColor: Color(0xff2e3233), //Gray Color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15,right: 10),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              Center(child: Text('Free Account',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              GoPremium(context),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              GestureDetector(
                  onTap: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children:
                          [
                            CircleAvatar(
                                //child:  image_url != null ? Image.network(image_url.toString(),fit: BoxFit.fill): Text('I',style: TextStyle(color: Colors.white, fontSize: 20),),
                                backgroundColor: ColorPalette().Genre_colors[ColorPalette().random_color.nextInt(ColorPalette().Genre_colors.length)],
                                radius: 30,
                                backgroundImage: image_url != null ? NetworkImage(image_url) : AssetImage("assets/images/NoUser.png"),
                              ),
                            SizedBox(width: 15,),
                            Column(
                              children: [
                                Align(alignment: Alignment.centerLeft,child: Text(
                                    user_name != null ? user_name : 'Your Name',
                                    style: GoogleFonts.roboto(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700))),
                                SizedBox(height: 2,),
                                GestureDetector(
                                  onTap: (){
                                    //profile link here
                                  },
                                  child: Text('View Profile',style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 14)),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                      Icon(Icons.navigate_next,color: Colors.white,size: 18,),
                    ],
                  ),
                ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              FlatButton(onPressed: ()async{
                final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
                try {
                  await googleSignIn.disconnect();
                }catch (e)
                {
                  print("Google Sign out Error: $e");
                }
                try{
                  await facebookLogin.logOut();
                }catch(e){
                  print("facebook sign out Error: $e");
                }
                try{
                  await _firebaseAuth.signOut();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignIn()), (Route<dynamic> route) => false);
                }catch (e){
                  print("Signing out error: $e");
                }
              },
                color: Colors.green.withOpacity(0.8),
                padding: EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Log out',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      Text('This logs your current account out',style: TextStyle(color: Colors.white.withOpacity(0.6)),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              Container(
                //data saver container
                child: Column(
                  children: [
                    Align(alignment:Alignment.centerLeft,
                        child: Headings('Data Saver'),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    Align(alignment:Alignment.centerLeft,
                        child: Minor_Headings('Data Saver'),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width-30,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.7,
                            child: SubHeadings('Sets your music quality to low (equivalent to 24Kbit/s) and disables artist canvases'),
                          ),
                          //Switches(switch1),
                          Switch(
                            value: switch1,
                            onChanged: (value) {
                              setState(() {
                                switch1 = value;
                              });
                            },
                            activeColor: Colors.green,
                            inactiveTrackColor: Colors.white70,

                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    Align(alignment:Alignment.centerLeft,
                        child: Minor_Headings('Audio-only Podcasts'),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width-30,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.7,
                            child: SubHeadings('Sets your music quality to low (equivalent to 24Kbit/s) and disables artist canvases'),
                          ),
                          //Switches(switch2),

                          Switch(
                            value: switch2,
                            onChanged: (value){
                              setState(() {
                                switch2 = value;
                              });
                            },
                            activeColor: Colors.green,
                            inactiveTrackColor: Colors.white70,

                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Headings('Playback'),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    Settings_Tile('Allows gapless playback', 'Gapless', _switch3),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    Settings_Tile('Allows smooth transitions between songs in a playlist.', 'Automix', switch4),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    Settings_Tile('Turn on to play explicit content\nExplicit content is labeled with E tag', 'Allow Explicit Content', switch5),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    Settings_Tile('Shows songs that are unplayable', 'Show unplayable songs', switch6),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    Settings_Tile('Set the same volume level for all tricks', 'Normalize Volume', switch7),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    Settings_Tile('Allow other apps on your device to see what you are listening to.', 'Device Broadcast Status', switch8),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    Settings_Tile('Keep on listening to similar tracks when your music ends', 'AutoPlay', switch9),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    Settings_Tile('Display short, looping visuals on tracks.', 'Canvas', switch10),
                    SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Headings('Languages')),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    Settings_Tile('Choose your preferred languages for music.', 'Languages for music', switch11),
                    SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Headings('Devices')),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    Settings_Tile('Listen to and control Soundify on your devices.', 'Connect to a Device',switch12),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  getImageUrl() async{
    User user = await auth.currentUser;
    FirebaseFirestore.instance.collection("Users").doc(user.uid).collection('UserData').doc('information').get().then((querySnapshot){
      setState(() {
        image_url = querySnapshot.data()["Photo_url"].toString();
        user_name = querySnapshot.data()["Name"].toString();
      });
    });
  }

  Widget GoPremium (BuildContext context)
  {
    return GestureDetector(
      onTap: (){
        getImageUrl();
      },
      child: Material(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.07,vertical: 15),
          child: AutoSizeText(
            'GO PREMIUM',
            maxLines: 1,
            minFontSize: 14,
            maxFontSize:20,
            style: GoogleFonts.raleway(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black),),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
      ),
    );
  }

  Widget Settings_Tile(String SubText,String HeadingText,bool switchValue)
  {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Minor_Headings('$HeadingText'),
          ),
          Container(
            width: MediaQuery.of(context).size.width-30,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: SubHeadings('$SubText'),
                ),
                Switch(
                  value: switchValue,
                  onChanged: (bool value) {
                    setState(() {
                      switchValue = value;
                      print(switchValue);
                    });
                  },
                  activeColor: Colors.green,
                  inactiveTrackColor: Colors.white70,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Headings(String text)
  {
    return Text('$text',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 16),);
  }

  Widget Minor_Headings(String text)
  {
    return Text('$text',
      style: TextStyle(color: Colors.white,fontSize: 16),);
  }

  Widget SubHeadings(String Text)
  {
    return AutoSizeText('$Text',
        maxLines: 4,
        style: TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 14));
  }

  Widget Switches(bool switchValue)
  {
    return Switch(
      value: switchValue,
      onChanged: (bool value) {
        setState(() {
          switchValue = value;
          print(switchValue);
        });
      },
      activeColor: Colors.green,
      inactiveTrackColor: Colors.white70,
    );
  }


}
