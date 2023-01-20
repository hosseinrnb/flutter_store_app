import 'package:flutter/material.dart';
import 'package:flutter_store_app/constants/color.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 216,
        width: 160,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                const SizedBox(width: double.infinity),
                Image.asset('assets/images/iphone.png'),
                Positioned(
                  top: 0,
                  right: 10,
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset('assets/images/active_fav_product.png'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                      child: Text(
                        '%3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'SB',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                'آیفون 13 پرومکس',
                style: TextStyle(
                  fontFamily: 'SM',
                  fontSize: 14,
                ),
              ),
            ),
            const Spacer(),
            Container(
              height: 53,
              decoration: const BoxDecoration(
                color: CustomColor.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: CustomColor.blue,
                    blurRadius: 25,
                    spreadRadius: -12,
                    offset: Offset(0.0, 15.0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 20,
                      child: Image.asset('assets/images/icon_right_arrow_circle.png'),
                    ),
                    const SizedBox(width: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: const[
                        Text(
                          '49،800،000',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SM',
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          '48،800،000',
                          style: TextStyle(
                            fontSize: 15.5,
                            fontFamily: 'SM',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Text(
                      'تومان',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'SM',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
