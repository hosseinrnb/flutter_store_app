import 'package:flutter/material.dart';
import 'package:flutter_store_app/constants/color.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  const LoadingIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 60,
        height: 60,
        child: LoadingIndicator(
          indicatorType: Indicator.ballRotateChase,
          colors: [CustomColor.blue],
          strokeWidth: 2,
        ),
      ),
    );
  }
}
