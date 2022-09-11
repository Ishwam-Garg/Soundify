import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soundify/screens/OtherScreens/PlaylistPage_SilverAppBar.dart';
import 'package:soundify/AppFunctions/Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OuterPlaylistTile extends StatefulWidget {
  String url,name;
  OuterPlaylistTile(this.url,this.name);

  @override
  _OuterPlaylistTileState createState() => _OuterPlaylistTileState();
}

class _OuterPlaylistTileState extends State<OuterPlaylistTile> with SingleTickerProviderStateMixin{

  AnimationController animationController;

  AddrecentlyPlayedPlaylist(String name,String url) async{
    User user = await auth.currentUser;
    DocumentReference ref = FirebaseFirestore.instance.collection("Users").doc(user.uid);
    Map<String,String> PlaylistData={
      'name': name,
      'url': url,
    };
    ref.collection("Recently Played Playlist").doc(name).set(PlaylistData);
  }

  Widget Playlist_Card(BuildContext context,String url,String name,AnimationController animationController){
    Animation<double> scale = Tween<double>(begin: 1.0, end: 0.95).animate(animationController);
    return ScaleTransition(
      scale: scale,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (_) async {
          await animationController.forward();
          await animationController.reverse();
        },
        onPanDown: (_) async {
          await animationController.forward();
          await animationController.reverse();
        },
        onTap: (){
          Navigator.push(context, CupertinoPageRoute(builder: (context) => PlaylistPage_SilverAppBar(name,url)));
          AddrecentlyPlayedPlaylist(name, url);
        },
        child: Container(
          margin: EdgeInsets.only(left: 15),
          height: 140,
          width: 150,
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
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Playlist_Card(context, widget.url, widget.name, animationController);
  }
}
