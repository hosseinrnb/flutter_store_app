import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_store_app/constants/color.dart';
import 'package:flutter_store_app/di/di.dart';
import 'package:flutter_store_app/screens/card_screen.dart';
import 'package:flutter_store_app/screens/category_screen.dart';
import 'package:flutter_store_app/screens/home_screen.dart';
import 'package:flutter_store_app/screens/product_detail_screen.dart';
import 'package:flutter_store_app/screens/profile_screen.dart';
import 'package:flutter_store_app/widgets/banner_slider.dart';
import 'package:flutter_store_app/widgets/horizontal_category.dart';
import 'package:flutter_store_app/widgets/product_item.dart';
import 'package:flutter_store_app/screens/product_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedBottomNavigationIndex = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
          index: selectedBottomNavigationIndex,
          children: getScreens(),
        ),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: BottomNavigationBar(
              onTap: (int index) {
                setState(() {
                  selectedBottomNavigationIndex = index;
                });
              },
              currentIndex: selectedBottomNavigationIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedLabelStyle: const TextStyle(
                fontFamily: 'SB',
                fontSize: 10,
                color: CustomColor.blue,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'SB',
                fontSize: 10,
                color: Colors.black,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/icon_profile.png'),
                  activeIcon: Container(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Image.asset('assets/images/icon_profile_active.png'),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0.0, 13),
                        )
                      ],
                    ),
                  ),
                  label: 'حساب کاربری',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/icon_basket.png'),
                  activeIcon: Container(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Image.asset('assets/images/icon_basket_active.png'),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0.0, 13),
                        )
                      ],
                    ),
                  ),
                  label: 'سبد خرید',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/icon_category.png'),
                  activeIcon: Container(
                    padding: const EdgeInsets.only(bottom: 3),
                    child:
                        Image.asset('assets/images/icon_category_active.png'),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0.0, 13),
                        )
                      ],
                    ),
                  ),
                  label: 'دسته بندی',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/icon_home.png'),
                  activeIcon: Container(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Image.asset('assets/images/icon_home_active.png'),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0.0, 13),
                        )
                      ],
                    ),
                  ),
                  label: 'خانه',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getScreens() {
    return <Widget>[
      const ProfileScreen(),
      //ProductDetailScreen(),
      const CardScreen(),
      const CategoryScreen(),
      const HomeScreen(),
    ];
  }
}
