import 'package:flutter/material.dart';

class My_Albums extends StatefulWidget {
  @override
  _My_AlbumsState createState() => _My_AlbumsState();
}

class _My_AlbumsState extends State<My_Albums> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
      child: Column(
        children: [
          Center(child: Text('Playlists',style: TextStyle(color: Colors.white),),),
        ],
      ),
    );
  }
}
