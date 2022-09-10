import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'SearchPlaylist.dart';
import 'SearchSongs.dart';

class Search_Page extends StatefulWidget {
  @override
  _Search_PageState createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {

  String hint = 'Search';
  TextAlign aligntext = TextAlign.center;
  //make a text controller here
  TextEditingController searchTextController = TextEditingController(text: "");

  String searchString;
  int _CurrentIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity,70),
        child: AppBar(
          backgroundColor: Colors.black,
          titleSpacing: -10,
          title: Container(
            width: MediaQuery.of(context).size.width*0.8,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: TextFormField(
              controller: searchTextController,
              onChanged: (value){
                setState(() {
                  searchString = value;
                });
              },
              onSaved: (value){
                setState(() {
                  searchString = value;
                });
              },
              onTap: (){
                setState(() {
                  hint = '';
                  aligntext = TextAlign.left;
                    });
                  },
                  obscureText: false,
                  cursorColor: Colors.green,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: aligntext,
                  decoration: InputDecoration(
                    hintText: '$hint',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: (){

                      },
                      child: Icon(Icons.camera_enhance,color: Colors.white38,),
                    ),
                    hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,decoration: TextDecoration.none),
                  ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff222222),
          elevation: 0,
          currentIndex: _CurrentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          onTap: (index){
            setState(() {
              _CurrentIndex = index;
              _pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: _CurrentIndex == 0 ? Icon(EvaIcons.music) : Icon(EvaIcons.musicOutline),
              label: 'Songs',
            ),
            BottomNavigationBarItem(
              icon: _CurrentIndex == 1 ? Icon(MdiIcons.folder) : Icon(MdiIcons.folderOutline),
              label: 'Playlists',
            ),
          ]
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        pageSnapping: true,
        children: [
          SearchSong(searchString),
          SearchPlaylist(searchString),
        ],
      ),

    );
  }

  Widget SongTile(BuildContext context,String name,String artists,String image,String url){
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        width: double.infinity,
        //height: MediaQuery.of(context).size.height*0.2,
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 20),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Image.network(image),
            ),
            SizedBox(width: 20,),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$name",style: TextStyle(color: Colors.white,fontSize: 18),),
                  SizedBox(height: 5,),
                  Text("$artists",style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 14,)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}

