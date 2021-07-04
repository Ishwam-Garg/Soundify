import 'package:flutter/material.dart';

class My_Artists extends StatefulWidget {
  @override
  _My_ArtistsState createState() => _My_ArtistsState();
}

class _My_ArtistsState extends State<My_Artists> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
      child: Column(
        children: [
          Center(child: Text('Artists',style: TextStyle(color: Colors.white),),),
        ],
      ),
    );
  }
}
