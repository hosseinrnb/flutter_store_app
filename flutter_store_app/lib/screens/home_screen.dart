import 'package:flutter/material.dart';
import 'package:flutter_store_app/constants/color.dart';
import 'package:flutter_store_app/widgets/product_item.dart';
import 'package:flutter_store_app/widgets/banner_slider.dart';
import 'package:flutter_store_app/widgets/horizontal_category.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreen,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 44, right: 44, top: 20, bottom: 10),
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
                          'جستوجوی محصولات',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SB',
                            color: CustomColor.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Image.asset('assets/images/icon_search.png'),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: BannerSlider(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(right: 44, left: 44, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'دسته بندی',
                      style: TextStyle(fontFamily: 'SB', color: CustomColor.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.only(right: 44),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: ((context, index){
                        return const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: CategoryHorizontalItem(),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(right: 44, left: 44, bottom: 20, top: 5),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_left_category.png'),
                    const SizedBox(width: 10),
                    const Text(
                      'مشاهده همه',
                      style: TextStyle(fontFamily: 'SB', color: CustomColor.blue),
                    ),
                    const Spacer(),
                    const Text(
                      'پرفروش ترین ها',
                      style: TextStyle(fontFamily: 'SB', color: CustomColor.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.only(right: 44),
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: ((context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: ProductItem(),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(right: 44, left: 44, bottom: 20, top: 32),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_left_category.png'),
                    const SizedBox(width: 10),
                    const Text(
                      'مشاهده همه',
                      style: TextStyle(fontFamily: 'SB', color: CustomColor.blue),
                    ),
                    const Spacer(),
                    const Text(
                      'پربازدید ترین ها',
                      style: TextStyle(fontFamily: 'SB', color: CustomColor.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.only(right: 44, bottom: 10),
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: ((context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: ProductItem(),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
