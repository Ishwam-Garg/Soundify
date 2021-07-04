import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:soundify/Constants/Color_Pallete.dart';
import 'package:soundify/screens/OtherScreens/PodcastsScreens/DownloadsScreens.dart';
import 'package:soundify/screens/OtherScreens/PodcastsScreens/EpisodesScreens.dart';
import 'package:soundify/screens/OtherScreens/PodcastsScreens/ShowsScreen.dart';


class PodcastLibrary extends StatefulWidget {
  @override
  _PodcastLibraryState createState() => _PodcastLibraryState();
}

class _PodcastLibraryState extends State<PodcastLibrary> {

  int _CurrentPage = 0;

  BoxDecoration activePageDecoration = BoxDecoration(color: Colors.black, border: Border(bottom: BorderSide(color: Colors.green,width: 3)),);

  BoxDecoration inActivePageDecoration = BoxDecoration(color: Colors.black);

  List<Widget> _PodCastPages = [Episodes_Screen(),Downloads_Screens(),Shows_Screens()];

  PageController _pageController = PageController(initialPage: 0);


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
            child: Row(
              children: [
                HeaderTiles('Episodes', 0),
                SizedBox(width: 15,),
                HeaderTiles('Downloads', 1),
                SizedBox(width: 15,),
                HeaderTiles('Shows', 2),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: ScrollPhysics(),
        pageSnapping: true,
        onPageChanged: (value){
          setState(() {
            _CurrentPage = value;
          });
        },
        children: [
          Episodes_Screen(),
          Downloads_Screens(),
          Shows_Screens()
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
