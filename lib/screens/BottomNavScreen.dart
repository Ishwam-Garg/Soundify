import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:soundify/screens/mainScreens/HomeScreen.dart';
import 'package:soundify/screens/mainScreens/PremiumScreen.dart';
import 'package:soundify/screens/mainScreens/LibraryScreen.dart';
import 'package:soundify/screens/mainScreens/SearchScreenSilverApp.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {

  int _currentIndex = 0;

  List<Widget> routes = [HomeScreen(),SearchPageSliver(),LibraryScreen(),PremiumScreen()];

  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.9),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          allowImplicitScrolling: true,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: List.generate(routes.length, (index) => routes[index]),
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,
            elevation: 5,
            currentIndex: _currentIndex,
            unselectedIconTheme: IconThemeData(
              color: Colors.white.withOpacity(0.8),
              size: 20,
            ),
            selectedIconTheme: IconThemeData(
              color: Colors.white,
              size: 24,
            ),
            unselectedItemColor: Colors.white.withOpacity(0.6),
            selectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedLabelStyle: TextStyle(color: Colors.white.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 12),
            selectedLabelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _pageController.jumpToPage(index);
              });
            },
          items: [
              BottomNavigationBarItem(
                  icon: _currentIndex == 0 ? Icon(Icons.home) : Icon(MdiIcons.homeOutline),
                  label: 'Home',
                  //title: Text('Home',),
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              //title: Text('Search'),
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 2 ? Icon(MdiIcons.tagMultiple) : Icon(MdiIcons.tagMultipleOutline),
              label: 'Your Library',
              //title: AutoSizeText('Your Library',maxLines: 1,),
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 3 ? Icon(Icons.stars) : Icon(MdiIcons.starCircleOutline),
              label: 'Premium',
              //title: Text('Premium'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed ()
  {
    SystemNavigator.pop();
  }

}
