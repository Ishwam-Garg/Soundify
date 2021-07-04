import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soundify/screens/OtherScreens/PlaylistPage_SilverAppBar.dart';

class SearchPlaylist extends StatefulWidget {
  final String searchText;

  const SearchPlaylist(this.searchText);
  @override
  _SearchPlaylistState createState() => _SearchPlaylistState();
}

class _SearchPlaylistState extends State<SearchPlaylist> {
  
  String searchString;
  
  Future getPlayList() async{
    QuerySnapshot qn = await FirebaseFirestore.instance.collection("PlaylistForYou").get();
    return qn.docs;
  }

  Future getSearchedPlaylist() async{
    QuerySnapshot qn = await FirebaseFirestore.instance.collection("PlaylistForYou").where("searchIndex",arrayContains: searchString).get();
    return qn.docs;
  }
  
  @override
  Widget build(BuildContext context) {
    searchString = widget.searchText;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: (searchString == null || searchString == "")
            ? getPlayList()
            : getSearchedPlaylist(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting)
              {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xff878787),
                  ),
                );
              }
              else if(snapshot.data.length==0)
              {
                return Container(
                  child: AutoSizeText("No Playlists Found!!",maxLines: 1,style: TextStyle(color: Colors.white.withOpacity(0.8)),),
                );
              }
              else{
                return Column(
                  children: List.generate(snapshot.data.length, (index) => PlaylistTile(
                    context,
                    snapshot.data[index].data()["name"],
                    snapshot.data[index].data()["url"],
                  )),
                );
              }
            }
        ),
      ),
    );
  }

  Widget PlaylistTile(BuildContext context,String name,String image){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PlaylistPage_SilverAppBar(name, image)));
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
              backgroundImage: NetworkImage(image),
            ),
            SizedBox(width: 20,),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText("$name",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: 18),),
                  //SizedBox(height: 5,),
                  //AutoSizeText("$artists",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 14,)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
