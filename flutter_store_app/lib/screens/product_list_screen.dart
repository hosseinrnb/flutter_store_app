import 'package:flutter/material.dart';
import 'package:flutter_store_app/constants/color.dart';
import 'package:flutter_store_app/widgets/product_item.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreen,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 35, right: 35, top: 20, bottom: 10),
                child: Container(
                  height: 46,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Image.asset('assets/images/icon_filter.png'),
                        const Expanded(
                          child: Text(
                            'پرفروش ترین ها',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'SB',
                              color: CustomColor.blue,
                            ),
                          ),
                        ),
                        Image.asset('assets/images/icon_back.png'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30,
                  childAspectRatio: 2 / 2.8,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return const ProductItem();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
