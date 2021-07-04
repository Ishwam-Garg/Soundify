import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:soundify/PlaySong/SongPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlaylistPage_SilverAppBar extends StatefulWidget {

  final String playlist_name;
  final String image_url;

  const PlaylistPage_SilverAppBar(this.playlist_name,this.image_url);

  @override
  _PlaylistPage_SilverAppBarState createState() => _PlaylistPage_SilverAppBarState();
}

class _PlaylistPage_SilverAppBarState extends State<PlaylistPage_SilverAppBar> {

  bool liked = false;
  var top = 0.0;

  Future getSongData() async{
    QuerySnapshot qn = await FirebaseFirestore.instance.collection("PlaylistForYou").doc(widget.playlist_name).collection("Songs").get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxScrolled){
              return <Widget>[
                SliverAppBar(
                  backgroundColor: top == 80.0 ? Colors.black : Colors.black,
                  pinned: true,
                  snap: false,
                  floating: true,
                  expandedHeight: MediaQuery.of(context).size.height*0.6,
                  actions: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          liked = liked==true ? false : true;
                        });
                      },
                      child: liked == false ? Icon(EvaIcons.heartOutline,color: Colors.white,size: 28,): Icon(EvaIcons.heart,color: Colors.green,size: 32,),
                    ),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){},
                      child: Icon(Icons.more_vert,color: Colors.white,size: 32,),
                    ),
                    SizedBox(width: 10,),
                  ],
                  flexibleSpace: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
                    top = constraints.biggest.height;
                    return FlexibleSpaceBar(
                      title: top==80.0 ? Text(widget.playlist_name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),) : Text(''),
                      centerTitle: true,
                      background: Container(
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                            //Container to display the icon/image of Playlist
                            Container(
                              width: MediaQuery.of(context).size.width*0.45,
                              height: MediaQuery.of(context).size.height*0.25,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(widget.image_url),
                                  fit: BoxFit.fill
                                ),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors : [
                                      Color(0xff296d98),
                                      Color(0xff1c4966),
                                    ]),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                            Text(widget.playlist_name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                            SizedBox(height: 5,),
                            Text('BY SOUNDIFY . 7,296 LIKES',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w500,fontSize: 10),),
                            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                            RoundPlayButton(context),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ];
              },
            body: SingleChildScrollView(
              child: FutureBuilder(
                            future: getSongData(),
                            builder: (context,snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting)
                              {
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Color(0xff878787),
                                  ),
                                );
                              }
                              else if(snapshot.data.length==0)
                                {
                                  return Center(
                                    child: Text('No Songs in this Playlist Currently',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                                  );
                                }
                              else
                              {
                                return Column(
                                    children: List.generate(snapshot.data.length, (index) =>
                                    SongTile(
                                        context,
                                      snapshot.data[index].data()["name"],
                                      snapshot.data[index].data()["artists"],
                                      snapshot.data[index].data()["image"],
                                      snapshot.data[index].data()["audio"],
                                    ),
                                    ),
                                  );
                              }
                            }
                        ),
            ),
        ),
      ),
    );
  }

  Widget RoundPlayButton(BuildContext context)
  {
    return GestureDetector(
      onTap: (){},
      child: Container(
        height: MediaQuery.of(context).size.height*0.075,
        width: MediaQuery.of(context).size.width*0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.1),
          color: Colors.green,
        ),
        child: Center(child: Text('Play',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),),
      ),
    );
  }

  Widget SongTile(BuildContext context,String song_name,String artist_name,String image_url,String audio_url)
  {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => PlaySongPage(song_name,image_url,audio_url,artist_name)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: MediaQuery.of(context).size.width*0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        //for image of song
                          image: DecorationImage(
                          image: NetworkImage(image_url),
                          fit: BoxFit.fill,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width*0.15,
                      height: MediaQuery.of(context).size.width*0.15,
                    ),
                  ),
                  SizedBox(width: 15,),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //name of song
                        Text(song_name,overflow: TextOverflow.fade,maxLines: 1,style: TextStyle(color: Colors.white,fontSize: 18)),
                        SizedBox(height: 5,),
                        //Singers of Song
                        Text(artist_name,overflow: TextOverflow.fade,maxLines: 2,textAlign: TextAlign.left,style: TextStyle(color: Colors.white38,fontSize: 12),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.more_vert,color: Colors.white38,),
            ),
          ],
        ),
      ),
    );
  }


}
