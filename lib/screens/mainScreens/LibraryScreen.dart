import 'package:soundify/screens/OtherScreens/LibraryMusicScreen.dart';
import 'package:soundify/screens/OtherScreens/LibraryPodcasts.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';


class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {

  int _CurrentPage = 0;

  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: AppBar(
          backgroundColor: Colors.black,
          leading: Container(),
          titleSpacing: -40,
          title: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              child: Row(
                children: [
                  HeaderTile('Music', 0),
                  SizedBox(width: 20,),
                  HeaderTile('Podcasts', 1),
                ],
              ),
            ),
          ),
        ),
      ),
      body: PageView(
        reverse: false,
        onPageChanged: (value){
          setState(() {
            _CurrentPage = value;
          });
        },
        controller: _pageController,
        pageSnapping: true,
        physics: BouncingScrollPhysics(),
        children: [
          MusicLibrary(),
          PodcastLibrary(),
        ],
      ),
    );
  }

  Widget HeaderTile(String text,int index)
  {
    return GestureDetector(
      onTap: (){
        setState(() {
          _CurrentPage = index;
          _pageController.animateToPage(index, duration: Duration(milliseconds: 2), curve: Curves.easeIn);
        });
      },
      child: AutoSizeText(text,style: TextStyle(color: _CurrentPage == index ? Colors.white:Colors.white70,fontWeight: FontWeight.bold,fontSize: 30),),
    );
  }

}
