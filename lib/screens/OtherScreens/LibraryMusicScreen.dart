import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:soundify/Constants/Color_Pallete.dart';
import 'package:soundify/screens/OtherScreens/MusicScreens/MyPlaylists.dart';
import 'package:soundify/screens/OtherScreens/MusicScreens/MyAlbums.dart';
import 'package:soundify/screens/OtherScreens/MusicScreens/MyArtists.dart';


class MusicLibrary extends StatefulWidget {
  @override
  _MusicLibraryState createState() => _MusicLibraryState();
}

class _MusicLibraryState extends State<MusicLibrary> {

  int _CurrentPage = 0;

  BoxDecoration activePageDecoration = BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.green,width: 3)),);

  BoxDecoration inActivePageDecoration = BoxDecoration(color: Colors.black);

  List<String> PageNames = ['Playlists','Artists','Albums'];

  List<Widget> MusicPages = [My_Playlists(),My_Artists(),My_Albums()];

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Container(),
        titleSpacing: -40,
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: double.infinity,
            child:
            Row(
              children: [
                HeaderTiles('Playlists', 0),
                SizedBox(width: 15,),
                HeaderTiles('Artists', 1),
                SizedBox(width: 15,),
                HeaderTiles('Albums', 2),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _CurrentPage = value;
          });
        },
        reverse: false,
        physics: ScrollPhysics(),
        pageSnapping: true,
        children: [
          My_Playlists(),
          My_Artists(),
          My_Albums(),
        ],
      ),
    );
  }

  Widget HeaderTiles (String text,int index)
  {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      decoration: _CurrentPage == index ? activePageDecoration : inActivePageDecoration,
      child: GestureDetector(
        onTap: (){
          setState(() {
            _CurrentPage = index;
            _pageController.animateToPage(index, duration:Duration(milliseconds: 2), curve: Curves.easeIn);
          });
        },
        child: AutoSizeText(text,
          style: TextStyle(color: _CurrentPage == index?ColorPalette().activepagecolor:ColorPalette().inactivepagecolor,fontWeight: FontWeight.bold,fontSize: 18),),
      ),
    );
  }


  }
