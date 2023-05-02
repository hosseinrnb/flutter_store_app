import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/bloc/product/product_bloc.dart';
import 'package:flutter_store_app/bloc/product/product_event.dart';
import 'package:flutter_store_app/bloc/product/product_state.dart';
import 'package:flutter_store_app/constants/color.dart';
import 'package:flutter_store_app/data/model/product_image.dart';
import 'package:flutter_store_app/data/model/product_variant.dart';
import 'package:flutter_store_app/data/model/variant.dart';
import 'package:flutter_store_app/widgets/cached_image.dart';

import '../data/model/variant_type.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(ProductInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreen,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is ProductDetailLoadingState) ...[
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 35, right: 35, top: 20, bottom: 10),
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
                            Image.asset('assets/images/icon_apple_blue.png'),
                            const Expanded(
                              child: Text(
                                'آیفون',
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
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 22, bottom: 20),
                    child: Text(
                      'آیفون 13 پرومکس',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontFamily: 'SB', fontSize: 16),
                    ),
                  ),
                ),
                if (state is ProductDetailResponseState) ...[
                  state.productImages.fold((l) {
                    return SliverToBoxAdapter(child: Text(l));
                  }, (r) {
                    return GalleryWidget(r);
                  })
                ],
                if (state is ProductDetailResponseState) ...[
                  state.productVariants.fold((l) {
                    return SliverToBoxAdapter(child: Text(l));
                  }, (r) {
                    return VariantContainerGenerator(r);
                  })
                ],
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 44, right: 44, top: 20),
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: CustomColor.grey, width: 1),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Text(
                              'مشخصات فنی:',
                              style: TextStyle(fontFamily: 'SM', fontSize: 12),
                            ),
                            const Spacer(),
                            const Text(
                              'مشاهده',
                              style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12,
                                  color: CustomColor.blue),
                            ),
                            const SizedBox(width: 10),
                            Image.asset('assets/images/icon_left_category.png'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 44, right: 44, top: 20),
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: CustomColor.grey, width: 1),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Text(
                              'توضیحات محصول:',
                              style: TextStyle(fontFamily: 'SM', fontSize: 12),
                            ),
                            const Spacer(),
                            const Text(
                              'مشاهده',
                              style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12,
                                  color: CustomColor.blue),
                            ),
                            const SizedBox(width: 10),
                            Image.asset('assets/images/icon_left_category.png'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 44, vertical: 20),
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: CustomColor.grey, width: 1),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            const Text(
                              'نظرات کاربران:',
                              style: TextStyle(fontFamily: 'SM', fontSize: 12),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Image.asset('assets/images/profile1.png'),
                                  Positioned(
                                    right: 15,
                                    child: Image.asset(
                                        'assets/images/profile2.png'),
                                  ),
                                  Positioned(
                                    right: 30,
                                    child: Image.asset(
                                        'assets/images/profile3.png'),
                                  ),
                                  Positioned(
                                    right: 45,
                                    child: Image.asset(
                                        'assets/images/profile4.png'),
                                  ),
                                  Positioned(
                                    right: 60,
                                    child: Container(
                                      height: 26,
                                      width: 26,
                                      decoration: const BoxDecoration(
                                        color: CustomColor.grey,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '+10',
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              fontFamily: 'SB',
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'مشاهده',
                              style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 12,
                                  color: CustomColor.blue),
                            ),
                            const SizedBox(width: 10),
                            Image.asset('assets/images/icon_left_category.png'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 44, vertical: 20),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: const [
                          AddToBasketButton(),
                          Spacer(),
                          PriceTagButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  List<ProductVariant> productVariantList;
  VariantContainerGenerator(
    this.productVariantList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var productVariant in productVariantList) ...{
            if (productVariant.variantList.isNotEmpty) ...{
              VariantGeneratorChild(productVariant),
            },
          },
        ],
      ),
    );
  }
}

class VariantGeneratorChild extends StatelessWidget {
  ProductVariant productVariant;
  VariantGeneratorChild(this.productVariant, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 44, right: 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariant.variantType.title,
            style: const TextStyle(fontFamily: 'SM', fontSize: 12),
          ),
          const SizedBox(height: 10),
          if (productVariant.variantType.type == VariantTypeEnum.COLOR) ...{
            ColorVariantList(productVariant.variantList)
          },
          if (productVariant.variantType.type == VariantTypeEnum.STORAGE) ...{
            StorageVariantList(productVariant.variantList)
          },
        ],
      ),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  List<ProductImage> productImageList;
  int selectedItem = 0;
  GalleryWidget(
    this.productImageList, {
    Key? key,
  }) : super(key: key);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: 285,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/icon_star.png'),
                      const Text(
                        '4.6',
                        style: TextStyle(fontFamily: 'SM', fontSize: 12),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: double.infinity,
                        child: CachedImage(
                            imageUrl: widget
                                .productImageList[widget.selectedItem]
                                .imageUrl),
                      ),
                      const Spacer(),
                      Image.asset('assets/images/icon_favorite.png'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.productImageList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.selectedItem = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: CustomColor.grey,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: CachedImage(
                                imageUrl:
                                    widget.productImageList[index].imageUrl),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  const AddToBasketButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: const BoxDecoration(
            color: CustomColor.blue,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: Container(
              height: 53,
              width: 160,
              color: Colors.transparent,
              child: const Center(
                child: Text(
                  'افزودن به سبد خرید',
                  style: TextStyle(
                    fontFamily: 'SB',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  const PriceTagButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: const BoxDecoration(
            color: CustomColor.green,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: Container(
              height: 53,
              width: 160,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 15,
                      width: 25,
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(7.5))),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                        child: Text(
                          '%5',
                          textDirection: TextDirection.rtl,
                          //textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'SB',
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '۱۷٬۸۰۰٬۰۰۰',
                          style: TextStyle(
                            fontFamily: 'SM',
                            color: Colors.white,
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          '۱۶٬۹۸۹٬۰۰۰',
                          style: TextStyle(
                            fontFamily: 'SB',
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'تومان',
                      style: TextStyle(
                        fontFamily: 'SM',
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ColorVariantList extends StatefulWidget {
  List<Variant> variantsList;
  ColorVariantList(this.variantsList, {super.key});

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  List<Widget> colorWidgets = [];

  @override
  void initState() {
    for (var colorVariant in widget.variantsList) {
      String variantColors = 'ff${colorVariant.value}';
      int hexColor = int.parse(variantColors, radix: 16);
      var item = Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 26,
        width: 26,
        decoration: BoxDecoration(
          color: Color(hexColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
      );
      colorWidgets.add(item);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colorWidgets.length,
          itemBuilder: (context, index) {
            return colorWidgets[index];
          },
        ),
      ),
    );
  }
}

class StorageVariantList extends StatefulWidget {
  List<Variant> storageVariants;
  StorageVariantList(this.storageVariants, {super.key});

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  List<Widget> storageWigets = [];

  @override
  void initState() {
    for (var storageVariant in widget.storageVariants) {
      var item = Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 26,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: CustomColor.grey, width: 1),
        ),
        child: Center(
          child: Text(
            storageVariant.value,
            style: const TextStyle(fontFamily: 'SM', fontSize: 12),
          ),
        ),
      );
      storageWigets.add(item);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: storageWigets.length,
          itemBuilder: (context, index) {
            return storageWigets[index];
          },
        ),
      ),
    );
  }
}
