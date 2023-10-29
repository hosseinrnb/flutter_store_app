import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/bloc/authentication/auth_bloc.dart';
import 'package:flutter_store_app/bloc/authentication/auth_state.dart';
import 'package:flutter_store_app/constants/color.dart';
import 'package:flutter_store_app/main.dart';
import 'package:flutter_store_app/screens/dashboard_screen.dart';
import 'package:flutter_store_app/screens/login_screen.dart';
import 'package:flutter_store_app/util/auth_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreen,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 44, right: 44, top: 20, bottom: 32),
              child: Container(
                height: 46,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Image.asset('assets/images/icon_apple_blue.png'),
                    const Expanded(
                      child: Text(
                        'حساب کاربری',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'SB',
                          color: CustomColor.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                AuthManger.logOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ));
              },
              child: const Text('خروج'),
            ),
            const Text(
              'حسین روان بخش',
              style: TextStyle(fontFamily: 'SB', fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              '09123456789',
              style: TextStyle(fontFamily: 'SM', fontSize: 10),
            ),
            const SizedBox(height: 20),
            const Directionality(
              textDirection: TextDirection.rtl,
              child: Wrap(
                spacing: 40,
                runSpacing: 40,
                children: [
                  // CategoryHorizontalItem(),
                  // CategoryHorizontalItem(),
                  // CategoryHorizontalItem(),
                  // CategoryHorizontalItem(),
                  // CategoryHorizontalItem(),
                  // CategoryHorizontalItem(),
                  // CategoryHorizontalItem(),
                  // CategoryHorizontalItem(),
                  // CategoryHorizontalItem(),
                  // CategoryHorizontalItem(),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              'اپل شاپ',
              style: TextStyle(
                  fontSize: 10, fontFamily: 'SM', color: CustomColor.grey),
            ),
            const Text(
              'V-1.0.0.00',
              style: TextStyle(
                  fontSize: 10, fontFamily: 'SM', color: CustomColor.grey),
            ),
            const Text(
              'instagram.com/hossein_rvnbakhsh',
              style: TextStyle(
                  fontSize: 10, fontFamily: 'SM', color: CustomColor.grey),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
