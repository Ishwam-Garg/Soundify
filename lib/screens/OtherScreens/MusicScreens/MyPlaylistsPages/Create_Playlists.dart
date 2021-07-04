import 'package:flutter/material.dart';
import 'package:soundify/Constants/Color_Pallete.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:soundify/screens/OtherScreens/MusicScreens/MyPlaylistComponents.dart';

class CreatePlaylists extends StatefulWidget {
  @override
  _CreatePlaylistsState createState() => _CreatePlaylistsState();

}

class _CreatePlaylistsState extends State<CreatePlaylists> {

  String PlaylistName;
  Color color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    color = ColorPalette().Genre_colors[ColorPalette().random_color.nextInt(ColorPalette().Genre_colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){},
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  color,
                  Colors.black,
                ],
            ),
          ),
          height: double.infinity,
          width: double.infinity,
          child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText('Give your Playlist a Name',maxLines: 2,maxFontSize: 22,minFontSize: 12,
                        style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: 22,fontWeight: FontWeight.w700),),
                      SizedBox(height: MediaQuery.of(context).size.height*0.01),
                      Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width*0.8,
                        child: TextFormField(
                          showCursor: true,
                          cursorColor: Colors.white,
                          obscureText: false,
                          maxLines: 2,
                          scrollPhysics: ScrollPhysics(),
                          onSaved: (value) {
                            setState(() {
                              PlaylistName =value;
                            });
                          },
                          onChanged: (value){
                            setState(() {
                              PlaylistName = value;
                            });
                          },
                          style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,),
                            ),
                          ),
                          textAlign: TextAlign.center,

                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: Text('Cancel',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w500,fontSize: 16),),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              if(PlaylistName!= null) {
                                Components().AddCreatedPlaylist(PlaylistName,null);
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                                child: Text('Save',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w500,fontSize: 16),),
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
