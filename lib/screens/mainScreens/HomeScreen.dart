import'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundify/Constants/Color_Pallete.dart';
import 'package:soundify/Constants/Strings.dart';
import 'package:soundify/screens/mainScreens/HomeScreenComponents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soundify/AppFunctions/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:marquee/marquee.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  AnimationController animationController;
  Animation<double> scale;
  User user = auth.currentUser;

  Future getPlaylistData() async{
    QuerySnapshot qn = await FirebaseFirestore.instance.collection('PlaylistForYou').get();
    return qn.docs;
  }

  Future getRecentlyPlayedSongdata() async{
    User user = await auth.currentUser;
    QuerySnapshot qn = await FirebaseFirestore.instance.collection("Users").doc(user.uid).collection("Recently Played").get();
    return qn.docs;
  }

  Future getRecentlyPlayedPlaylistData() async{
    User user = await auth.currentUser;
    QuerySnapshot qn = await FirebaseFirestore.instance.collection("Users").doc(user.uid).collection("Recently Played Playlist").get();
    return qn.docs;
  }

  Future getAllSongs() async{
    QuerySnapshot qn = await FirebaseFirestore.instance.collection("Songs").get();
    return qn.docs;
  }

  Future<Null> refreshPage() async{

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Loading',style: TextStyle(color: Colors.blue.shade600,fontSize: 18),),
            Text('Updating this page',style: TextStyle(color: Colors.white,fontSize: 14),),
          ],
        ),
    ));

    await Future.delayed(Duration(seconds: 2));
    setState(() {

      });
  }

  Color color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    scale = Tween<double>(begin: 1.0, end: 0.95).animate(animationController);
    setState(() {
      color = ColorPalette().Genre_colors[ColorPalette().random_color.nextInt(ColorPalette().Genre_colors.length)];
    });
  }


  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    var timenow = int.parse(DateFormat('kk').format(now));
    var welcometext = '';

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

    return RefreshIndicator(
      onRefresh: refreshPage,
      backgroundColor: Colors.white,
      color: color,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: SingleChildScrollView(
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
                              future: getRecentlyPlayedPlaylistData(),
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
                                    height: 150,
                                    child: ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context,index){
                                        return Components().Playlist_Card(
                                            context,
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
                  FutureBuilder(
                      future: getPlaylistData(),
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
                                      fontSize: 20,
                                    ),)),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height*0.03,
                              ),
                              Container(
                                height: 150,
                                width: double.infinity,
                                child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                    itemBuilder: (context,index){
                                        return Components().Playlist_Card(context, snapshot.data[index].data()["url"], snapshot.data[index].data()["name"]);
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
                                        fontSize: 20
                                    ),)),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height*0.03,
                              ),
                              Container(
                                //margin: EdgeInsets.symmetric(horizontal: 20),
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.docs.length <= 12 ? snapshot.data.docs.length : 12,
                                  itemBuilder: (context,index){
                                    DocumentSnapshot data = snapshot.data.docs[index];
                                    return Components().SongCard(
                                        context,
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
                        future: getAllSongs(),
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
                                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height*0.03,
                                ),
                                Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      itemCount:  snapshot.data.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context,index)
                                      {
                                        return Components().SongCard(
                                          context,
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
                ],
              ),
        ),
      ),
    );
  }

}
