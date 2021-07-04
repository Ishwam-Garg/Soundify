import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';



class AddSong_to_Playlist extends StatefulWidget {

  final String Playlistname;
  final String image_url;


  const AddSong_to_Playlist(this.Playlistname,this.image_url);

  @override
  _AddSong_to_PlaylistState createState() => _AddSong_to_PlaylistState();
}

class _AddSong_to_PlaylistState extends State<AddSong_to_Playlist> {

  bool liked = false;
  var top = 0.0;


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
                backgroundColor: top == 80.0 ? Colors.black : Colors.transparent,
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
                    title: top==80.0 ? Text(widget.Playlistname,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),) : Text(''),
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
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors : [
                                    Color(0xff296d98),
                                    Color(0xff1c4966),
                                  ]),
                            ),
                            child: widget.image_url == null ? Icon(EvaIcons.heart,color: Colors.white,): Image.network(widget.image_url,fit: BoxFit.fill,),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                          Text(widget.Playlistname,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                          SizedBox(height: 5,),
                          Text('By You',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w500,fontSize: 10),),
                          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                          RoundAddButton(context),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Container(),
          ),
        ),
      ),
    );
  }

  Widget RoundAddButton(BuildContext context)
  {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        height: MediaQuery.of(context).size.height*0.075,
        width: MediaQuery.of(context).size.width*0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.1),
          color: Colors.green,
        ),
        child: Center(child: Text('Add Songs',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),),
      ),
    );
  }

}
