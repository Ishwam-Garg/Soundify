import'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundify/Components/OuterPlaylistTile.dart';
import 'package:soundify/Components/OuterSongTile.dart';
import 'package:soundify/Constants/Color_Pallete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soundify/AppFunctions/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soundify/Services/HomeService.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  AnimationController animationController;
  Animation<double> scale;
  User user = auth.currentUser;
  Color color;
  String welcometext = '';

  void setWelcomeText(){
    DateTime now = DateTime.now();
    var timenow = int.parse(DateFormat('kk').format(now));

    if(timenow <12)
    {
      setState(() {
        welcometext = 'Good Morning';
      });
    }
    else if ((timenow >= 12) && (timenow <= 16))
    {
      setState(() {
        welcometext = 'Good Afternoon';
      });
    }
    else if ((timenow >16) && (timenow <=24))
    {
      setState(() {
        welcometext = 'Good Evening';
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    scale = Tween<double>(begin: 1.0, end: 0.95).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    color = ColorPalette().Genre_colors[ColorPalette().random_color.nextInt(ColorPalette().Genre_colors.length)];
    setWelcomeText();
    return RefreshIndicator(
      onRefresh: (){
        return HomeService().refreshPage(context);
      },
      backgroundColor: Colors.white,
      color: color,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    //height: MediaQuery.of(context).size.height*0.45, // need this
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            color,
                            Colors.black,
                          ]
                      ),
                    ),
                    child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(welcometext,
                                  style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, 'Settings');
                                  },
                                  child: Container(
                                      width: 50,
                                      height: 30,
                                      child: Icon(Icons.settings,color: Colors.white,size: 28)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.02,
                          ),
                          FutureBuilder(
                              future: HomeService().getRecentlyPlayedPlaylistData(),
                              builder: (context,snapshot){
                                if(snapshot.connectionState==ConnectionState.waiting)
                                {
                                  return Container();
                                }
                                else if(snapshot.data.length==0)
                                  {
                                    return Container();
                                  }
                                else{
                                  return Container(
                                    height: 140,
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context,index){
                                        return OuterPlaylistTile(
                                            snapshot.data[index].data()["url"],
                                            snapshot.data[index].data()["name"],
                                        );
                                      },
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  );
                                }
                              },
                            ),
                        ],
                      ),
                  ),
                  SizedBox(height: 15,),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Users").doc(user.uid).collection("Recently Played").orderBy("TimeStamp",descending: true).snapshots(),
                    builder: (context,snapshot){
                      if(snapshot.hasData && snapshot.data.docs.length != 0)
                      {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText('Recently Played Songs',maxLines: 1,style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 1.5,
                                  ),)),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.03,
                            ),
                            Container(
                              height: 140,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.docs.length <= 12 ? snapshot.data.docs.length : 12,
                                itemBuilder: (context,index){
                                  DocumentSnapshot data = snapshot.data.docs[index];
                                  return OuterSongTile(
                                    data["name"],
                                    data["image"],
                                    data["audio"],
                                    data["artists"],
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      else
                        return Container();
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.03,
                  ),
                  FutureBuilder(
                    future: HomeService().getAllSongs(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting)
                      {
                        return Container();
                      }
                      else{
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText('All Songs',
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 1.5,
                                    ),)),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.03,
                            ),
                            Container(
                              height: 140,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount:  snapshot.data.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,index)
                                  {
                                    return OuterSongTile(
                                      snapshot.data[index].data()["name"],
                                      snapshot.data[index].data()["image"],
                                      snapshot.data[index].data()["audio"],
                                      snapshot.data[index].data()["artists"],
                                    );
                                  }
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20,),
                  FutureBuilder(
                      future: HomeService().getPlaylistData(),
                      builder: (context,snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting)
                          {
                            return Container();
                          }
                        else{
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: AutoSizeText('Playlists For You',maxLines: 1,style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 1.5,
                                    ),)),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height*0.03,
                              ),
                              Container(
                                height: 140,
                                width: double.infinity,
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                    itemBuilder: (context,index){
                                        return OuterPlaylistTile(
                                            snapshot.data[index].data()["url"],
                                            snapshot.data[index].data()["name"],
                                        );
                                    },
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                  ),
                  SizedBox(height: 10,),
                ],
              ),
        ),
      ),
    );
  }

}
