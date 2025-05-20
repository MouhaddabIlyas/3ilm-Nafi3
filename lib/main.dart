import 'package:_3ilm_nafi3/screens/adkars_page.dart';
import 'package:_3ilm_nafi3/screens/myvideos.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
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
        '/adminConsole': (context) => AdminPage(),
        '/admin_video_page': (context) => AdminValidationPage(),
        '/page1': (context) => TawhidPage(),
        '/page2':
            (context) => ThemePage(
              theme: "Prière",
              videosPath: "33b5b607-10f7-4b40-a1ad-8becbcfa7983",
              imagePath: "assets/images/2.jpg",
            ),
        '/page3':
            (context) => ThemePage(
              theme: "Ramadan",
              videosPath: "3ae58ae9-1178-48eb-b243-0a6a80b152fc",
              imagePath: "assets/images/3.jpg",
            ),
        '/page4':
            (context) => ThemePage(
              theme: "Zakat",
              videosPath: "6265bc0c-da24-485a-ba44-624e993fe142",
              imagePath: "assets/images/4.jpg",
            ),
        '/page5':
            (context) => ThemePage(
              theme: "Hajj",
              videosPath: "f63b2ecf-e196-4057-b357-45f33461a838",
              imagePath: "assets/images/5.jpg",
            ),
        '/page6':
            (context) => ThemePage(
              theme: "Le Coran",
              videosPath: "8a50dbd8-8923-4e34-ac02-e7d720dad88d",
              imagePath: "assets/images/6.jpg",
            ),
        '/page7':
            (context) => ThemePage(
              theme: "La Sunna",
              videosPath: "352f15b9-c261-4a3c-99ce-e1c5cbfa0124",
              imagePath: "assets/images/7.jpg",
            ),
        '/page8':
            (context) => ThemePage(
              theme: "Prophètes",
              videosPath: "46c17b28-18fa-4e4b-9ff1-0ce9dbdfab8a",
              imagePath: "assets/images/8.jpg",
            ),
        '/page9':
            (context) => ThemePage(
              theme: "73 Sectes",
              videosPath: "2e2c05ea-78bd-408d-a4b7-4211706c2a7b",
              imagePath: "assets/images/9.jpg",
            ),
        '/page10':
            (context) => ThemePage(
              theme: "Compagnons",
              videosPath: "59bd80d8-6062-4b9a-87d8-aa5b3c35c132",
              imagePath: "assets/images/10.jpg",
            ),
        '/page11':
            (context) => ThemePage(
              theme: "Les Savants",
              videosPath: "f112e63a-6a48-4c5f-ad65-c7104173323c",
              imagePath: "assets/images/11.jpg",
            ),
        '/page12':
            (context) => ThemePage(
              theme: "Les innovations",
              videosPath: "bb190f80-c716-4d5e-8536-ab47cf4c1631",
              imagePath: "assets/images/12.jpg",
            ),
        '/page13':
            (context) => ThemePage(
              theme: "La mort",
              videosPath: "cf875d8b-6f5e-4997-bcf2-fc607c093016",
              imagePath: "assets/images/13.jpg",
            ),
        '/page14':
            (context) => ThemePage(
              theme: "La tombe",
              videosPath: "5ca65b2a-eef1-44f5-a5a0-80a27ec9f1e9",
              imagePath: "assets/images/14.jpg",
            ),
        '/page15':
            (context) => ThemePage(
              theme: "Le jour dernier",
              videosPath: "bce54aa7-6d2e-42f3-8060-4981361ae608",
              imagePath: "assets/images/15.jpg",
            ),
        '/page16':
            (context) => ThemePage(
              theme: "Les 4 Imams",
              videosPath: "d66f7970-5705-4d24-bd9a-416b8bb87da2",
              imagePath: "assets/images/16.jpg",
            ),
        '/page17':
            (context) => ThemePage(
              theme: "Les Anges",
              videosPath: "335366ac-0609-437b-8406-4c7a23fdd5b6",
              imagePath: "assets/images/17.jpg",
            ),
        '/page18':
            (context) => ThemePage(
              theme: "Les Djinns",
              videosPath: "b1e66682-3d08-4f97-91a2-93653d6cd30f",
              imagePath: "assets/images/18.jpg",
            ),
        '/page19':
            (context) => ThemePage(
              theme: "Les gens du livre",
              videosPath: "155a63ac-fc32-42f8-8279-de65c64aede0",
              imagePath: "assets/images/19.jpg",
            ),
        '/page20':
            (context) => ThemePage(
              theme: "99 Noms",
              videosPath: "9cb2ef65-2872-4a6f-9ca6-216b4b353066",
              imagePath: "assets/images/20.jpg",
            ),
        '/page21':
            (context) => ThemePage(
              theme: "Femmes",
              videosPath: "470d3f3d-648f-4e1d-975a-3c95a05324bd",
              imagePath: "assets/images/21.jpg",
            ),
        '/page22':
            (context) => ThemePage(
              theme: "Voyage",
              videosPath: "f0ae858f-0957-4795-939b-138503bb2d64",
              imagePath: "assets/images/22.jpg",
            ),
        '/page23':
            (context) => ThemePage(
              theme: "Signes",
              videosPath: "932e21e2-19ee-47b8-98c2-4b0f65723dfd",
              imagePath: "assets/images/23.jpg",
            ),
        '/page24':
            (context) => ThemePage(
              theme: "Adkars",
              videosPath: "54187de6-a52c-4209-843a-efcdca5ee780",
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
  int _currentIndex = 1;

  final List<Widget> _pages = [
    // ServicesScreen(),
    TermsAndConditionsPage(),
    HomeScreen(),
    //AdkarsPage(),
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
        items: [
          /*
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Services',
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/logo.png'),
              color:
                  _currentIndex == 1
                      ? Colors.white
                      : const Color.fromARGB(134, 0, 0, 0),
              size: 60,
            ),
            label: 'Home',
          ),
          /*
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Settings',
          ),*/
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
