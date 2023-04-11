import 'package:flutter/material.dart';
import 'package:flutter_store_app/data/model/banner.dart';
import 'package:flutter_store_app/widgets/cached_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_store_app/constants/color.dart';

class BannerSlider extends StatelessWidget {
  List<MyBanner> bannerList;
  BannerSlider(this.bannerList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(viewportFraction: 0.9);

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 177,
          child: PageView.builder(
            controller: controller,
            itemCount: bannerList.length,
            itemBuilder: ((context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: CachedImage(
                  imageUrl: bannerList[index].thumbnail,
                ),
              );
            }),
          ),
        ),
        Positioned(
          bottom: 15,
          child: SmoothPageIndicator(
            controller: controller,
            count: bannerList.length,
            effect: const ExpandingDotsEffect(
              expansionFactor: 2,
              // dotHeight: 10,
              // dotWidth: 10,
              dotColor: Colors.white,
              activeDotColor: CustomColor.blueIndicator,
            ),
          ),
        ),
      ],
    );
  }
}

// Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.all(Radius.circular(15)),
//                   ),
//                 ),
//               )