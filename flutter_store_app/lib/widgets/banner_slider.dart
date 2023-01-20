import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_store_app/constants/color.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    PageController controller = PageController(viewportFraction: 0.85);
    int item = 5;

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: controller,
            itemCount: item,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              );
            }),
          ),
        ),
        Positioned(
          bottom: 15,
          child: SmoothPageIndicator(
            controller: controller,
            count: item,
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
