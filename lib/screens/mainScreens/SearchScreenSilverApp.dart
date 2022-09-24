import 'package:flutter/material.dart';
import 'package:soundify/screens/mainScreens/SearchingPages/SearchScreenComponents.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundify/Constants/Color_Pallete.dart';
import 'package:soundify/Constants/Strings.dart';

class SearchPageSliver extends StatefulWidget {
  @override
  _SearchPageSliverState createState() => _SearchPageSliverState();
}

class _SearchPageSliverState extends State<SearchPageSliver> {

  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerScrollBox){
              double height = MediaQuery.of(context).size.height;
              return <Widget>[
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  backgroundColor: Colors.black,
                  expandedHeight: height*0.25 > 250 ? 250 : height*0.25,
                  leading: Container(),
                  flexibleSpace: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints)
                          {
                            top = constraints.biggest.height;
                            print(top);
                            return FlexibleSpaceBar(
                              centerTitle: true,
                              background: Container(
                                height: 200,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    SizedBox(height: MediaQuery.of(context).size.height*0.075,),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: AutoSizeText('Search',
                                        maxLines: 1,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context).size.width*0.1,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                                    Components().SearchBar(context),
                                  ],
                                ),
                              ),
                              titlePadding: EdgeInsets.symmetric(horizontal: 10),
                              title: top <= 100.0 ? Components().SearchBar(context) : Container(),
                            );
                          }),
                ),
              ];
            },
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                reverse: false,
                primary: true,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      top <= 60.0 ? Components().SearchBar(context) : Container(),
                      SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          'Your to genres',
                          maxLines: 1,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                      //to make cards for Genres
                      Flexible(
                        fit: FlexFit.loose,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height*0.37,
                          width: double.infinity,
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            physics: ScrollPhysics(),
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: (MediaQuery.of(context).size.width-20)/(MediaQuery.of(context).size.height*0.3),
                            children: List.generate(
                              Strings().Your_Genres.length,
                                  (index) => Components().GenreCard(context,Strings().Your_Genres[index],ColorPalette().Genre_colors[ColorPalette().random_color.nextInt(ColorPalette().Genre_colors.length)]),
                              growable: false,
                            ),
                          ),
                        ),
                      ),
                      //SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          'Browse All',
                          maxLines: 1,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height*1.8,
                          width: double.infinity,
                          child: GridView.count(
                            scrollDirection: Axis.vertical,
                            crossAxisCount: 2,
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: (MediaQuery.of(context).size.width-20)/(MediaQuery.of(context).size.height*0.3),
                            children: List.generate(Strings().AllGenres.length,
                                  (index) => Components().GenreCard(context,Strings().AllGenres[index],ColorPalette().Genre_colors[ColorPalette().random_color.nextInt(ColorPalette().Genre_colors.length)]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }
}
