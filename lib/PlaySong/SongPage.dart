import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:marquee/marquee.dart';
import 'package:soundify/AppFunctions/Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';

class PlaySongPage extends StatefulWidget {

  final String songname;
  final String image_url;
  final String song_url;
  final String artists_names;
  const PlaySongPage(this.songname,this.image_url,this.song_url,this.artists_names);

  @override
  _PlaySongPageState createState() => _PlaySongPageState();
}


class _PlaySongPageState extends State<PlaySongPage> {

  String song_url = 'https://assets.mixkit.co/music/preview/mixkit-trip-hop-vibes-149.mp3';

  bool isliked = false;

  double slider_value = 0.0;

  bool song_playing = true;

  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache cache;

  Duration totalDuration; //total time of song
  Duration position; //position of song played
  String audioState;

  initAudio(){
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      setState(() {
        totalDuration = updatedDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      setState(() {
        position = updatedPosition;
      });
    });
    audioPlayer.onPlayerStateChanged.listen((playerState) {
          if(playerState==AudioPlayerState.STOPPED)
            {
              setState(() {
                audioState = "Stopped";
              });
            }
          if(playerState==AudioPlayerState.PLAYING)
            {
              setState(() {
                audioState = "Playing";
              });
            }
          if(playerState==AudioPlayerState.PAUSED)
          {
            setState(() {
              audioState = "Paused";
            });
          }

    });
  }

  playAudio()
  {
    audioPlayer.play(widget.song_url);
    AddRecentlyPlayedSong();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAudio();
    playAudio();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xff444444),
                Colors.black,
              ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              //false app bar
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 10,
                            child: InkWell(
                              splashColor: Color(0x878787),
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.black.withOpacity(0.4),
                                child: Container(
                                  child: Icon(Icons.navigate_before,color: Colors.white,size: 34,),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Container(
                        child: Column(
                          children: [
                            Text('Now Playing',style: TextStyle(color: Color(0xff989898,),fontSize: 18),),
                            SizedBox(height: 5,),
                            Container(
                                width: MediaQuery.of(context).size.width*0.65,
                                height: 40,
                                child: widget.songname.toString().length < 30 ? Text(
                                  widget.songname.toString(),
                                  style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 16),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ) :
                                Marquee(
                                  text: widget.songname,
                                  style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 16),
                                  scrollAxis: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  blankSpace: 50,
                                  velocity: 30.0,
                                  pauseAfterRound: Duration.zero,
                                  numberOfRounds: null,
                                  startPadding: 0,
                                ),

                            ),
                          ],
                        ),
                      ),
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.4),
                            child: PopupMenuButton(
                              icon: Icon(Icons.more_vert,color: Colors.white,),
                              elevation: 5,
                              color: Color(0xff333333),
                              itemBuilder: (context)=>[
                                PopupMenuItem(
                                  child: GestureDetector(
                                    onTap: (){},
                                    child: Container(
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Text('Add to favourites',style: TextStyle(color: Colors.white),),
                                          SizedBox(width: 10,),
                                          Icon(Icons.star,color: Colors.white,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  child: GestureDetector(
                                    onTap: (){},
                                    child: Container(
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Text('Add to playlist',style: TextStyle(color: Colors.white),),
                                          SizedBox(width: 10,),
                                          Icon(Icons.playlist_add,color: Colors.white,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  child: GestureDetector(
                                    onTap: (){},
                                    child: Container(
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Text('Repeat',style: TextStyle(color: Colors.white),),
                                          SizedBox(width: 10,),
                                          Icon(Icons.repeat,color: Colors.white,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],

                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              //song cover image
              Container(
                height: MediaQuery.of(context).size.width*0.7,
                width: MediaQuery.of(context).size.width*0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: NetworkImage(widget.image_url),
                    fit: BoxFit.fill,
                  )
                ),
              ),
              SizedBox(height: 12,),
              //name tile
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.songname,style: TextStyle(color: Colors.white,fontSize: 20),),//song name
                        SizedBox(height: 10,),
                        Container(
                            width: MediaQuery.of(context).size.width*0.7,
                            height: 20,
                            child: widget.artists_names.length <= 15 ? Text(
                            widget.artists_names.toString(),
                            style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 16),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ) :
                          Marquee(
                            text: widget.artists_names.toString(),
                            style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 16),
                            scrollAxis: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            blankSpace: 50,
                            velocity: 30.0,
                            pauseAfterRound: Duration.zero,
                            numberOfRounds: null,
                            startPadding: 0,
                          ),
                          //Text(widget.artists_names, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Color(0xff989898),fontSize: 18),)
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isliked = isliked == true ? false : true ;
                        });
                      },
                      child: Container(
                          child: isliked == true ? Icon(MdiIcons.heart,color: Colors.green,) : Icon(MdiIcons.heartOutline,color: Colors.white,)),
                    ),
                  ],
                ),
              ),
              //Slider to display Song
              Container(
                child: Column(
                  children: [
                    SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 5,
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                        ),
                        child: Slider(
                          value: position == null ? 0 : position.inMilliseconds.toDouble(),
                          activeColor: Colors.green,
                          inactiveColor: Color(0xff444444),
                          onChanged: (value){
                            setState(() {
                              slider_value = value;
                              audioPlayer.seek(Duration(milliseconds: value.toInt()));
                            });
                          },
                          min: 0,
                          max: totalDuration == null ? 20 : totalDuration.inMilliseconds.toDouble(), // to change according to size of track
                        ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(position ==  null ? '0:00' : position.toString().split('.').first,style: TextStyle(color: Color(0xff878787),fontSize: 14),),
                          Text(totalDuration == null ? '0.00' : totalDuration.toString().split('.').first,style: TextStyle(color: Color(0xff878787),fontSize: 14),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //Song Button Controls pause/play forward or backward
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: (){
                          if(position>=Duration(seconds: 10))
                          setState(() {
                            position-=Duration(seconds: 10);
                            slider_value  = position.inMilliseconds.toDouble();
                            audioPlayer.seek(Duration(milliseconds: slider_value.toInt()));
                          });
                          else
                            setState(() {
                              slider_value = 0;
                              audioPlayer.seek(Duration(milliseconds: slider_value.toInt()));
                            });

                      },
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                      child: Icon(Icons.fast_rewind,color: Colors.white,),
                      color: Color(0xff878787),
                    ),
                    MaterialButton(
                        onPressed: () {
                          if(!song_playing)
                            {
                              audioPlayer.play(widget.song_url);
                              setState(() {
                                song_playing = true;
                              });
                            }
                          else
                            {
                              audioPlayer.pause();
                              setState(() {
                                song_playing = false;
                              });
                            }
                        },
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(15),
                        child: playerStatus(audioState),
                        color: Colors.green,

                        ),
                    MaterialButton(
                      onPressed: (){
                        if(totalDuration - position > Duration(seconds: 20))
                        setState(() {
                          position += Duration(seconds: 10);
                          slider_value = position.inMilliseconds.toDouble();
                          audioPlayer.seek(Duration(milliseconds: slider_value.toInt()));
                        });
                        else
                          {

                          }
                      },
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                      child: Icon(Icons.fast_forward,color: Colors.white,),
                      color: Color(0xff878787),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text(audioState == null ? '' : audioState ,style: TextStyle(fontSize: 16,color: Colors.white.withOpacity(0.2)),)
            ],
          ),
        ),
      ),
    );
  }

  AddRecentlyPlayedSong() async{
    User user = await auth.currentUser;
    DocumentReference ref = FirebaseFirestore.instance.collection("Users").doc(user.uid);

    Map<String,dynamic> SongData={
      "name": widget.songname,
      "artists": widget.artists_names,
      "audio": widget.song_url,
      "image": widget.image_url,
      "TimeStamp": Timestamp.now(),
    };

    ref.collection("Recently Played").doc(widget.songname).set(SongData);

  }

  Icon playerStatus(String State){
    switch(State)
    {
      case 'Playing':{
        return Icon(Icons.pause,color: Colors.white,size: 34,);
      }
      case 'Stopped':{
        return Icon(Icons.stop,color: Colors.white,size: 34,);
      }
      case 'Paused':{
        return Icon(Icons.play_arrow,color: Colors.white,size: 34,);
      }
    }
  }

}
