import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soundify/AppFunctions/Auth.dart';

class HomeService {
  Future getPlaylistData() async{
    QuerySnapshot qn = await FirebaseFirestore.instance.collection('PlaylistForYou').get();
    return qn.docs;
  }

  Future getRecentlyPlayedSongdata() async{
    User user = auth.currentUser;
    QuerySnapshot qn = await FirebaseFirestore.instance.collection("Users").doc(user.uid).collection("Recently Played").get();
    return qn.docs;
  }

  Future getRecentlyPlayedPlaylistData() async{
    User user = auth.currentUser;
    QuerySnapshot qn = await FirebaseFirestore.instance.collection("Users").doc(user.uid).collection("Recently Played Playlist").get();
    return qn.docs;
  }

  Future getAllSongs() async{
    QuerySnapshot qn = await FirebaseFirestore.instance.collection("Songs").get();
    return qn.docs;
  }

  Future<Null> refreshPage(BuildContext context) async{
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
    return null;
  }
}