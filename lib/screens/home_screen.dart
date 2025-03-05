import 'package:flutter/material.dart';
import 'package:_3ilm_nafi3/constants.dart';
import 'package:_3ilm_nafi3/widgets/clickable_theme_item.dart';

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
    ScrollPhysics physics,
  ) {
    return GlowingOverscrollIndicator(
      axisDirection: axisDirection,
      color: Colors.white,
      child: child,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green,
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Expanded(
              child: Center(
                child: Image.asset("assets/images/title.png"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2 * MediaQuery.of(context).size.height / 3,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Thèmes',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: ClickableThemeItem(
                                    imagePath: 'assets/images/1.jpg',
                                    text: themes[0],
                                    routeName: '/page1',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          ...List.generate(12, (index) {
                            if (index != 11) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: ClickableThemeItem(
                                        imagePath:
                                            'assets/images/${index * 2 + 2}.jpg',
                                        text: themes[index * 2 + 1],
                                        routeName: '/page${index * 2 + 2}',
                                      ),
                                    ),
                                    Flexible(
                                      child: ClickableThemeItem(
                                        imagePath:
                                            'assets/images/${index * 2 + 3}.jpg',
                                        text: themes[index * 2 + 2],
                                        routeName: '/page${index * 2 + 3}',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: ClickableThemeItem(
                                        imagePath:
                                            'assets/images/${index * 2 + 2}.jpg',
                                        text: themes[index * 2 + 1],
                                        routeName: '/page${index * 2 + 2}',
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
