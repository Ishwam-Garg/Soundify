import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soundify/AppFunctions/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soundify/Constants/Color_Pallete.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:soundify/screens/OtherScreens/MusicScreens/MyPlaylistsPages/AddSongToPlaylistPage.dart';


class Components {

  Widget CreatePlaylistCard(BuildContext context,String text)
  {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'Create Playlist');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.width*0.2,
              width: MediaQuery.of(context).size.width*0.2,
              color: Colors.white12,
              child: Center(child: Text('+',style: TextStyle(color: Colors.white,fontSize: 54,fontWeight: FontWeight.w200),),),
            ),
            SizedBox(width: 15,),
            AutoSizeText('$text',maxLines: 2,minFontSize: 10,maxFontSize: 18,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
          ],
        ),
      ),
    );
  }

  AddCreatedPlaylist(String name,String url) async{
    User user = await auth.currentUser;
    DocumentReference ref = FirebaseFirestore.instance.collection("Users").doc(user.uid);
    Map<String,String> CreatedPlaylistData = {
      'name': name,
      'url': url,
    };
    ref.collection("My Playlists").doc(name).set(CreatedPlaylistData);
  }

  Widget PlaylistCard(BuildContext context,String name,String image){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
        AddSong_to_Playlist(
            name,
            image,
        ),
        ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        //width: double.infinity,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.2,
              height: MediaQuery.of(context).size.width*0.2,
              child: image == null ? Icon(EvaIcons.heart,color: Colors.white,) : Image.network(image),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorPalette().Genre_colors[ColorPalette().random_color.nextInt(ColorPalette().Genre_colors.length)],
                      Color(0xff878787),
                    ]),
              ),
            ),
            SizedBox(width: 20,),
            AutoSizeText(
              '$name',
              maxLines: 1,
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
          ],
        ),
      ),
    );
  }

  Widget LikedPlaylistCard(BuildContext context,String name,String image){
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        //width: double.infinity,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.2,
              height: MediaQuery.of(context).size.width*0.2,
              child: image == null ? Icon(EvaIcons.heart,color: Colors.white,) : Image.network(image),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorPalette().Genre_colors[ColorPalette().random_color.nextInt(ColorPalette().Genre_colors.length)],
                      Color(0xff878787),
                    ]),
              ),
            ),
            SizedBox(width: 20,),
            AutoSizeText(
              '$name',
              maxLines: 1,
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
          ],
        ),
      ),
    );
  }

}