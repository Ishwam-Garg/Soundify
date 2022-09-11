import 'package:flutter/material.dart';
import 'package:soundify/PlaySong/SongPage.dart';
import 'package:marquee/marquee.dart';

class OuterSongTile extends StatefulWidget {
  String name;
  String image;
  String song;
  String artists;
  OuterSongTile(this.name,this.image,this.song,this.artists);

  @override
  _OuterSongTileState createState() => _OuterSongTileState();
}

class _OuterSongTileState extends State<OuterSongTile> with SingleTickerProviderStateMixin {

  AnimationController animationController;
  Animation<double> scale;


  Widget SongCard(BuildContext context,String name,String image,String song,String artists){
    return GestureDetector(
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => PlaySongPage(name, image, song, artists)));
      },
      child: ScaleTransition(
        scale: scale,
        child: Container(
          height: 140,
          width: 150,
          margin: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.fill,
            ),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.25),
                    Colors.black.withOpacity(0.05),
                  ]
              )
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    width: 108,
                    child: Text(name.toString(),
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),
                      maxLines: 2,overflow: TextOverflow.clip,),
                  )
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  width: 120,
                  height: 30,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Marquee(
                      text: artists.toString().toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.grey.shade300),
                      blankSpace: 50,
                      showFadingOnlyWhenScrolling: true,
                      velocity: 15.0,
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      numberOfRounds: null,
                    ),
                  ),
                ),
              ),
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
    scale = Tween<double>(begin: 1.0, end: 0.95).animate(animationController);
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
    return SongCard(context, widget.name, widget.image, widget.song, widget.artists);
  }
}