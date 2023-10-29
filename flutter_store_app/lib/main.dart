import 'package:flutter/material.dart';
import 'package:flutter_store_app/data/model/card_item.dart';
import 'package:flutter_store_app/di/di.dart';
import 'package:flutter_store_app/screens/dashboard_screen.dart';
import 'package:flutter_store_app/screens/login_screen.dart';
import 'package:flutter_store_app/util/auth_manager.dart';
import 'package:hive_flutter/adapters.dart';

GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>('CardBox');
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
      navigatorKey: globalNavigatorKey,
      debugShowCheckedModeBanner: false,
      home: (AuthManger.readAuth().isEmpty)
          ? LoginScreen()
          : const DashBoardScreen(),
    );
  }
}
