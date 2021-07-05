import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundify/screens/OtherScreens/PlaylistPage_SilverAppBar.dart';
import 'package:soundify/PlaySong/SongPage.dart';
import 'package:soundify/AppFunctions/Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:marquee/marquee.dart';

class Components {
  
  Widget Playlist_Card(BuildContext context,String url,String name){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => PlaylistPage_SilverAppBar(name,url)));
        AddrecentlyPlayedPlaylist(name, url);
      },
      child: Container(
        margin: EdgeInsets.only(left: 15),
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
                top: 10,
                right: 10,
                child: Row(
                  children: [
                    Text('1.3K',style: TextStyle(color: Colors.white),),
                    Icon(Icons.play_arrow_sharp,color: Colors.white,),
                  ],
                )),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.15),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: Text(name,maxLines: 2,overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AddrecentlyPlayedPlaylist(String name,String url) async{
    User user = await auth.currentUser;
    DocumentReference ref = FirebaseFirestore.instance.collection("Users").doc(user.uid);
    Map<String,String> PlaylistData={
      'name': name,
      'url': url,
    };
    ref.collection("Recently Played Playlist").doc(name).set(PlaylistData);
  }


  Widget SongCard(BuildContext context,String name,String image,String song,String artists){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PlaySongPage(name, image, song, artists)));
      },
      child: Container(
        height: 160,
        width: 150,
        margin: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Expanded(child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.25),
                      Colors.black.withOpacity(0.05),
                    ]
                ),
              ),
            )),
            Positioned(
                top: 12,
                left: 12,
                child: Container(
                  width: 108,
                  child: Text(name.toString(),
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),
                    maxLines: 2,overflow: TextOverflow.clip,),
                )
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                width: 120,
                height: 30,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Marquee(
                    text: artists.toString().toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.grey.shade300),
                    blankSpace: 50,
                    showFadingOnlyWhenScrolling: true,
                    velocity: 15.0,
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    numberOfRounds: null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget RecentlyPlayedSong(BuildContext context,String name,String image,String song,String artists,Color color,)
  {
    return Container(
      color: Colors.black,
      width: MediaQuery.of(context).size.width*0.3,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => PlaySongPage(name, image, song, artists)));
            },
            child: CircleAvatar(
              backgroundColor: color,
              radius: (MediaQuery.of(context).size.width*0.13),
              backgroundImage: NetworkImage(image),
            ),
          ),
          SizedBox(height: 10,),
          Align(alignment: Alignment.center,
            child: AutoSizeText(
              name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
              maxLines: 2,
              minFontSize: 8,
              maxFontSize: 16,
            ),
          )
        ],
      ),
    );
  }

}
