import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundify/screens/splash_screen.dart';
import 'package:soundify/screens/SignInScreen.dart';
import 'package:soundify/screens/SignUpScreen.dart';
import 'package:soundify/screens/BottomNavScreen.dart';
import 'package:soundify/screens/mainScreens/HomeScreen.dart';
import 'package:soundify/screens/mainScreens/SearchScreenSilverApp.dart';
import 'package:soundify/screens/mainScreens/LibraryScreen.dart';
import 'package:soundify/screens/mainScreens/PremiumScreen.dart';
import 'package:soundify/screens/OtherScreens/SettingsScreen.dart';
import 'package:soundify/screens/OtherScreens/LibraryMusicScreen.dart';
import 'package:soundify/screens/OtherScreens/MusicScreens/MyPlaylists.dart';
import 'package:soundify/screens/OtherScreens/MusicScreens/MyAlbums.dart';
import 'package:soundify/screens/OtherScreens/MusicScreens/MyArtists.dart';
import 'package:soundify/screens/mainScreens/SearchingPages/SearchPage.dart';
import 'package:soundify/screens/OtherScreens/MusicScreens/MyPlaylistsPages/Create_Playlists.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
    });

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        'Sign': (context)=> SignIn(),
        'Sign Up': (context)=>SignUp(),
        'Bottom Nav':(context)=>BottomNavScreen(),
        'Home':(context)=>HomeScreen(),
        'Search':(context)=>Search_Page_Sliver(),
        'Library':(context)=>LibraryScreen(),
        'Premium':(context)=>PremiumScreen(),
        'Settings':(context)=>SettingsScreen(),
        'My Music': (context)=>MusicLibrary(),
        'My Playlists': (context)=>My_Playlists(),
        'My Artists': (context)=>My_Artists(),
        'My Albums': (context)=>My_Albums(),
        'Search Page': (context)=>Search_Page(),
        'Create Playlist': (context)=>CreatePlaylists(),
      },
    );
  }
}
