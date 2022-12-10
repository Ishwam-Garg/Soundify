import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:soundify/PlaySong/SongPage.dart';

class SearchSong extends StatefulWidget {

  final String searchText;

  const SearchSong(this.searchText);

  @override
  _SearchSongState createState() => _SearchSongState();
}

class _SearchSongState extends State<SearchSong> {
  String hint = 'Search';
  TextAlign aligntext = TextAlign.center;
  //make a text controller here
  TextEditingController searchTextController = TextEditingController(text: "");

  Future getSearchedSongs() async {
    QuerySnapshot qn = await FirebaseFirestore.instance.collection("Songs").where("searchIndex",arrayContains: searchString.replaceAll(' ', '').toLowerCase()).get();
    return qn.docs;
  }

  Future getSongsData() async{
    QuerySnapshot qn = await FirebaseFirestore.instance.collection('Songs').get();
    return qn.docs;
  }

  String searchString;

  @override
  Widget build(BuildContext context) {
    searchString = widget.searchText;
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height-60,
      color: Colors.black,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
          //future: (searchString == null || searchString == "") ? getSongsData() : getSearchedSongs(),
          future: getSongsData(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting)
            {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(height: 10,),
                      Text('Finding Best Results',style: TextStyle(fontSize: 12,color: Colors.white),),
                    ],
                  ),
                ),
              );
            }
            else if(snapshot.data.length==0)
            {
              return Container(
                child: AutoSizeText("No songs Found!!",maxLines: 1,style: TextStyle(color: Colors.white.withOpacity(0.8)),),
              );
            }
            else{
              return Column(
                children: List.generate(snapshot.data.length, (index){
                  String name = snapshot.data[index].data()["name"];
                  name = name.toLowerCase();
                  if(searchString!=null)
                  searchString = searchString.toLowerCase();
                  if(searchString == null || searchString.isEmpty || name.contains(searchString))
                  return SongTile(
                    context,
                    snapshot.data[index].data()["name"],
                    snapshot.data[index].data()["artists"],
                    snapshot.data[index].data()["image"],
                    snapshot.data[index].data()["audio"],
                  );
                  else
                    return Container();
                }),
              );
            }
          },
        ),
      ),
    );
  }

  Widget SongTile(BuildContext context,String name,String artists,String image,String url){
    if(url.isEmpty || name.isEmpty || image.isEmpty)
      return Container();
    else
    return GestureDetector(
      onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=> PlaySongPage(name, image, url, artists),
          ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height*0.2,
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05,vertical: 20),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(image),
                ),
              ),
            ),
            /*
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(image),
            ),
             */
            SizedBox(width: 20,),
            Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText("$name",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: 18),),
                      SizedBox(height: 5,),
                      AutoSizeText("$artists",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 14,)),
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }

}
