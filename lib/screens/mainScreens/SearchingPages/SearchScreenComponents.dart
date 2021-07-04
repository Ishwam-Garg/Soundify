import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class Components {

  Widget SearchBar(BuildContext context)
  {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'Search Page');
      },
      child: Container(
        color: Colors.black,
        width: double.infinity,
        height: MediaQuery.of(context).size.width*0.2,
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
        child: Material(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white.withOpacity(0.9),
          child: Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 5,),
                Icon(Icons.search,color: Colors.black,size: 24,),
                SizedBox(width: 5,),
                AutoSizeText(
                  'Artists,songs or podcasts',
                  maxLines: 1,
                  minFontSize: 10,
                  maxFontSize: 18,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget GenreCard(BuildContext context,String Genre_name,Color color)
  {
    return GestureDetector(
      onTap: (){},
      child: Container(
        width: MediaQuery.of(context).size.width*0.4,
        height: MediaQuery.of(context).size.height*0.02,
        child: Material(
          elevation: 5,
          color: color,
          borderRadius: BorderRadius.circular(5),
          child: Align(
            child:Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: AutoSizeText(
                  '$Genre_name',
                  maxLines: 2,
                  style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)
            ),
            alignment: Alignment.topLeft,
          ),
        ),
      ),
    );
  }

}