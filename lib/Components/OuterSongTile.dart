import 'package:flutter/material.dart';
import 'package:soundify/PlaySong/SongPage.dart';
import 'package:marquee/marquee.dart';
import 'package:cached_network_image/cached_network_image.dart';


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

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    scale = Tween<double>(
        begin: 1,
        end: 0.9).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget SongCard(BuildContext context,String name,String image,String song,String artists){
    if(song.isEmpty || name.isEmpty || image.isEmpty)
      return Container();
    else
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
          width: 140,
          margin: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                image,
              ),
              //image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                  child: Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff0D2C54).withOpacity(0.6),
                        Colors.black.withOpacity(0.05),
                        Color(0xff0D2C54).withOpacity(0.6),
                      ]
                  ),
                ),
              )),
              Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    width: 108,
                    child: Text(
                      name.toString(),
                      style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),
                      maxLines: 2,overflow: TextOverflow.clip,),
                  )
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                  width: 120,
                  height: 14,
                  //color: Colors.red,
                  child: Marquee(
                    text: artists.toString().toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: 9,color: Colors.grey.shade300),
                    blankSpace: 10,
                    showFadingOnlyWhenScrolling: true,
                    fadingEdgeStartFraction: 0.2,
                    fadingEdgeEndFraction: 0.2,
                    velocity: 15.0,
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    numberOfRounds: null,
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
  Widget build(BuildContext context) {
    return SongCard(context, widget.name, widget.image, widget.song, widget.artists);
  }
}
