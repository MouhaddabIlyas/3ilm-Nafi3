import 'package:_3ilm_nafi3/screens/adkars_page.dart';
import 'package:_3ilm_nafi3/screens/services_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:_3ilm_nafi3/constants.dart';
import 'package:_3ilm_nafi3/screens/admin_page.dart';
import 'package:_3ilm_nafi3/screens/admin_video_page.dart';
import 'package:_3ilm_nafi3/screens/home_screen.dart';
import 'package:_3ilm_nafi3/screens/login_screen.dart';
import 'package:_3ilm_nafi3/screens/profile_screen.dart';
import 'package:_3ilm_nafi3/screens/register_screen.dart';
import 'package:_3ilm_nafi3/screens/splash_screen.dart';
import 'package:_3ilm_nafi3/screens/tawhid_page.dart';
import 'package:_3ilm_nafi3/screens/terms_conditions_page.dart';
import 'package:_3ilm_nafi3/screens/theme_page.dart';
import 'package:_3ilm_nafi3/screens/video_screen.dart';

import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => MainPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/video_page': (context) => VideoPage(),
        '/adminConsole': (context) => AdminPage(),
        '/admin_video_page': (context) => AdminVideoPage(),
        '/page1': (context) => TawhidPage(),
        '/page2':
            (context) => ThemePage(
              theme: "Prière",
              videosPath: "",
              imagePath: "assets/images/2.jpg",
            ),
        '/page3':
            (context) => ThemePage(
              theme: "Ramadan",
              videosPath: "",
              imagePath: "assets/images/3.jpg",
            ),
        '/page4':
            (context) => ThemePage(
              theme: "Zakat",
              videosPath: "",
              imagePath: "assets/images/4.jpg",
            ),
        '/page5':
            (context) => ThemePage(
              theme: "Hajj",
              videosPath: "",
              imagePath: "assets/images/5.jpg",
            ),
        '/page6':
            (context) => ThemePage(
              theme: "Le Coran",
              videosPath: "",
              imagePath: "assets/images/6.jpg",
            ),
        '/page7':
            (context) => ThemePage(
              theme: "La Sunna",
              videosPath: "",
              imagePath: "assets/images/7.jpg",
            ),
        '/page8':
            (context) => ThemePage(
              theme: "Prophètes",
              videosPath: "",
              imagePath: "assets/images/8.jpg",
            ),
        '/page9':
            (context) => ThemePage(
              theme: "73 Sectes",
              videosPath: "",
              imagePath: "assets/images/9.jpg",
            ),
        '/page10':
            (context) => ThemePage(
              theme: "Compagnons",
              videosPath: "",
              imagePath: "assets/images/10.jpg",
            ),
        '/page11':
            (context) => ThemePage(
              theme: "Les Savants",
              videosPath: "",
              imagePath: "assets/images/11.jpg",
            ),
        '/page12':
            (context) => ThemePage(
              theme: "Les innovations",
              videosPath: "",
              imagePath: "assets/images/12.jpg",
            ),
        '/page13':
            (context) => ThemePage(
              theme: "La mort",
              videosPath: "",
              imagePath: "assets/images/13.jpg",
            ),
        '/page14':
            (context) => ThemePage(
              theme: "La tombe",
              videosPath: "",
              imagePath: "assets/images/14.jpg",
            ),
        '/page15':
            (context) => ThemePage(
              theme: "Le jour dernier",
              videosPath: "",
              imagePath: "assets/images/15.jpg",
            ),
        '/page16':
            (context) => ThemePage(
              theme: "Les 4 Imams",
              videosPath: "",
              imagePath: "assets/images/16.jpg",
            ),
        '/page17':
            (context) => ThemePage(
              theme: "Les Anges",
              videosPath: "",
              imagePath: "assets/images/17.jpg",
            ),
        '/page18':
            (context) => ThemePage(
              theme: "Les Djinns",
              videosPath: "",
              imagePath: "assets/images/18.jpg",
            ),
        '/page19':
            (context) => ThemePage(
              theme: "Les gens du livre",
              videosPath: "",
              imagePath: "assets/images/19.jpg",
            ),
        '/page20':
            (context) => ThemePage(
              theme: "99 Noms",
              videosPath: "",
              imagePath: "assets/images/20.jpg",
            ),
        '/page21':
            (context) => ThemePage(
              theme: "Femmes",
              videosPath: "",
              imagePath: "assets/images/21.jpg",
            ),
        '/page22':
            (context) => ThemePage(
              theme: "Voyage",
              videosPath: "",
              imagePath: "assets/images/22.jpg",
            ),
        '/page23':
            (context) => ThemePage(
              theme: "Signes",
              videosPath: "",
              imagePath: "assets/images/23.jpg",
            ),
        '/page24':
            (context) => ThemePage(
              theme: "Adkars",
              videosPath: "",
              imagePath: "assets/images/24.jpg",
            ),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Important note : if you encounter problems with the text them use this version of google_fonts: ^5.0.0
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      title: '3ilm Nafi3',
      home: SplashScreen(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 2;

  final List<Widget> _pages = [
    ServicesScreen(),
    TermsAndConditionsPage(),
    HomeScreen(),
    AdkarsPage(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: green,
        fixedColor: Colors.white,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 35,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Settings',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.mosque), label: 'Home'),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Settings',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
