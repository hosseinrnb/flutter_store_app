import 'package:flutter/material.dart';
import 'package:flutter_store_app/constants/color.dart';
import 'package:dotted_line/dotted_line.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreen,
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 44, right: 44, top: 20, bottom: 10),
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
                                'سبد خرید',
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
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return const CardItem();
                      },
                      childCount: 5,
                    ),
                  ),
                  const SliverPadding(padding: EdgeInsets.only(bottom: 50)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 10,),
                child: SizedBox(
                  height: 53,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: const Text(
                      'ادامه فرآیند خرید',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 44, vertical: 10),
      height: 249,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  const SizedBox(width: 8.0),
                  Image.asset('assets/images/iphone.png'),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'آیفون ۱۳ پرومکس دو سیم کارت',
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 15.0,
                            ),
                          ),
                          const Text(
                            'گارانتی 18 ماه مدیا پردازش',
                            style: TextStyle(
                              color: CustomColor.grey,
                              fontFamily: 'SM',
                              fontSize: 12.0,
                            ),
                          ),
                          Row(
                            children: [
                              const Text('۴۶٬۰۰۰٬۰۰۰ '),
                              const Text('تومان '),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 6),
                                  child: Text(
                                    '%۳',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'SB',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: CustomColor.grey, width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('۲۵۶ گیگابایت'),
                                  const SizedBox(width: 5),
                                  Image.asset('assets/images/icon_options.png'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: DottedLine(
                lineThickness: 3.0,
                dashLength: 8.0,
                dashColor: CustomColor.backgroundScreen,
                dashGapLength: 3.0,
                dashGapColor: Colors.transparent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('۴۵٬۳۵۰٬۰۰۰'),
                  SizedBox(width: 5),
                  Text('تومان'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
