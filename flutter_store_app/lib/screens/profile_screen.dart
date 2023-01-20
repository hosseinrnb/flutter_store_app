import 'package:flutter/material.dart';
import 'package:flutter_store_app/constants/color.dart';
import 'package:flutter_store_app/widgets/horizontal_category.dart';

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
              padding: const EdgeInsets.only(left: 44, right: 44, top: 20, bottom: 32),
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
            Directionality(
              textDirection: TextDirection.rtl,
              child: Wrap(
                spacing: 40,
                runSpacing: 40,
                children: const [
                  CategoryHorizontalItem(),
                  CategoryHorizontalItem(),
                  CategoryHorizontalItem(),
                  CategoryHorizontalItem(),
                  CategoryHorizontalItem(),
                  CategoryHorizontalItem(),
                  CategoryHorizontalItem(),
                  CategoryHorizontalItem(),
                  CategoryHorizontalItem(),
                  CategoryHorizontalItem(),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              'اپل شاپ',
              style: TextStyle(fontSize: 10, fontFamily: 'SM', color: CustomColor.grey),
            ),
            const Text(
              'V-1.0.0.00',
              style: TextStyle(fontSize: 10, fontFamily: 'SM', color: CustomColor.grey),
            ),
            const Text(
              'instagram.com/hossein_rvnbakhsh',
              style: TextStyle(fontSize: 10, fontFamily: 'SM', color: CustomColor.grey),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
