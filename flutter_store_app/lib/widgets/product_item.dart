import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/bloc/basket/basket_bloc.dart';
import 'package:flutter_store_app/bloc/product/product_bloc.dart';
import 'package:flutter_store_app/constants/color.dart';
import 'package:flutter_store_app/data/model/product.dart';
import 'package:flutter_store_app/di/di.dart';
import 'package:flutter_store_app/screens/product_detail_screen.dart';
import 'package:flutter_store_app/widgets/cached_image.dart';

class ProductItem extends StatelessWidget {
  Product product;
  ProductItem(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider<BasketBloc>.value(
                value: locator.get<BasketBloc>(),
                child: ProductDetailScreen(product),
              ),
            ),
          );
        },
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
                  SizedBox(
                    width: 95,
                    height: 95,
                    child: CachedImage(imageUrl: product.thumbnail),
                  ),
                  Positioned(
                    top: 0,
                    right: 10,
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child:
                          Image.asset('assets/images/active_fav_product.png'),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 6),
                        child: Text(
                          '%${product.persent!.round().toString()}',
                          style: const TextStyle(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  product.name,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
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
                        child: Image.asset(
                            'assets/images/icon_right_arrow_circle.png'),
                      ),
                      const SizedBox(width: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.price.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'SM',
                              color: Colors.white,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            product.realPrice.toString(),
                            style: const TextStyle(
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
      ),
    );
  }
}
