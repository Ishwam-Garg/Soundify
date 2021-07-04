import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:soundify/screens/OtherScreens/MusicScreens/MyPlaylistsPages/Create_Playlists.dart';
import 'package:soundify/screens/OtherScreens/MusicScreens/MyPlaylistComponents.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soundify/AppFunctions/Auth.dart';
import 'package:soundify/Constants/Color_Pallete.dart';

class My_Playlists extends StatefulWidget {
  @override
  _My_PlaylistsState createState() => _My_PlaylistsState();
}

class _My_PlaylistsState extends State<My_Playlists> {

  Future getPlaylistsData() async{
    User user = await auth.currentUser;
    QuerySnapshot qn = await FirebaseFirestore.instance.collection("Users").doc(user.uid).collection("My Playlists").get();
    return qn.docs;
  }

  Future<Null> RefreshPage() async{
    await Future.delayed(Duration(seconds: 2));
    setState(() {

    });
    }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: RefreshIndicator(
          onRefresh: RefreshPage,
          backgroundColor: Colors.white10,
          color: Colors.blue,
          strokeWidth: 5,
          child: Column(
            children: [
              Components().CreatePlaylistCard(context,'Create Playlist'),
              SingleChildScrollView(
                child: FutureBuilder(
                    future: getPlaylistsData(),
                    builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting)
                      {
                        return CircularProgressIndicator(
                          backgroundColor: Colors.black,
                        );
                      }
                    else if(snapshot.data.length == 0)
                      {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          child: AutoSizeText('Your added Playlists are displayed here',maxLines: 2,style: TextStyle(fontSize: 18,color: Colors.white.withOpacity(0.6)),),
                        );
                      }
                    else{
                      return Column(
                          children: List.generate(
                              snapshot.data.length,
                                  (index) =>
                                  Components().PlaylistCard(
                                      context,
                                      snapshot.data[index].data()['name'],
                                      snapshot.data[index].data()['url'],
                                  ),
                          ),
                        );
                    }
                }),
              ),
              //seperate Column For Liked Playlists
            ],
          ),
        ),
      ),
    );
  }


}
