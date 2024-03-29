import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/bloc/basket/basket_bloc.dart';
import 'package:flutter_store_app/bloc/basket/basket_event.dart';
import 'package:flutter_store_app/bloc/comment/comment_bloc.dart';
import 'package:flutter_store_app/bloc/comment/comment_event.dart';
import 'package:flutter_store_app/bloc/comment/comment_state.dart';
import 'package:flutter_store_app/bloc/product/product_bloc.dart';
import 'package:flutter_store_app/bloc/product/product_event.dart';
import 'package:flutter_store_app/bloc/product/product_state.dart';
import 'package:flutter_store_app/constants/color.dart';
import 'package:flutter_store_app/data/model/product.dart';
import 'package:flutter_store_app/data/model/product_image.dart';
import 'package:flutter_store_app/data/model/product_property.dart';
import 'package:flutter_store_app/data/model/product_variant.dart';
import 'package:flutter_store_app/data/model/variant.dart';
import 'package:flutter_store_app/di/di.dart';
import 'package:flutter_store_app/widgets/cached_image.dart';
import 'package:flutter_store_app/widgets/loading_animation.dart';
import '../data/model/variant_type.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = ProductBloc();
        bloc.add(
            ProductInitEvent(widget.product.id, widget.product.categoryId));
        return bloc;
      },
      child: DetailScreenContent(parentWidget: widget),
    );
  }
}

class DetailScreenContent extends StatelessWidget {
  const DetailScreenContent({
    Key? key,
    required this.parentWidget,
  }) : super(key: key);

  final ProductDetailScreen parentWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreen,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductDetailLoadingState) {
            return const LoadingIndicatorWidget();
          }
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is ProductDetailResponseState) ...{
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
                              Expanded(
                                child: state.productCategory.fold((l) {
                                  return const Text(
                                    'اطلاعات محصول',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'SB',
                                      color: CustomColor.blue,
                                    ),
                                  );
                                }, (r) {
                                  return Text(
                                    r.title!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'SB',
                                      color: CustomColor.blue,
                                    ),
                                  );
                                }),
                              ),
                              Image.asset('assets/images/icon_back.png'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                },
                if (state is ProductDetailResponseState) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 22, bottom: 20),
                      child: Text(
                        parentWidget.product.name,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(fontFamily: 'SB', fontSize: 16),
                      ),
                    ),
                  ),
                },
                if (state is ProductDetailResponseState) ...[
                  state.productImages.fold((l) {
                    return SliverToBoxAdapter(child: Text(l));
                  }, (r) {
                    return GalleryWidget(parentWidget.product.thumbnail, r);
                  })
                ],
                if (state is ProductDetailResponseState) ...[
                  state.productVariants.fold((l) {
                    return SliverToBoxAdapter(child: Text(l));
                  }, (r) {
                    return VariantContainerGenerator(r);
                  })
                ],
                if (state is ProductDetailResponseState) ...[
                  state.productProperties.fold((l) {
                    return SliverToBoxAdapter(child: Text(l));
                  }, (r) {
                    return ProductProperties(r);
                  })
                ],
                if (state is ProductDetailResponseState) ...{
                  ProductDescription(parentWidget.product.description),
                },
                if (state is ProductDetailResponseState) ...{
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: true,
                          useSafeArea: true,
                          showDragHandle: true,
                          context: context,
                          builder: (context) {
                            return BlocProvider(
                              create: (context) {
                                final bloc = CommentBloc(locator.get());
                                bloc.add(CommentInitilizeEvent(
                                    parentWidget.product.id));
                                return bloc;
                              },
                              child: CommentBottomSheet(
                                productId: parentWidget.product.id,
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 44, vertical: 20),
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
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
                                  style:
                                      TextStyle(fontFamily: 'SM', fontSize: 12),
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
                                Image.asset(
                                    'assets/images/icon_left_category.png'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                },
                if (state is ProductDetailResponseState) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 44, vertical: 20),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: [
                            AddToBasketButton(parentWidget.product),
                            const Spacer(),
                            const PriceTagButton(),
                          ],
                        ),
                      ),
                    ),
                  ),
                },
              ],
            ),
          );
        },
      ),
    );
  }
}

class CommentBottomSheet extends StatelessWidget {
  CommentBottomSheet({
    required this.productId,
    super.key,
  });

  final String productId;
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentLoading) {
          return const LoadingIndicatorWidget();
        }
        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  if (state is CommentResponse) ...{
                    state.response.fold((l) {
                      return const SliverToBoxAdapter(
                        child: Text('خطایی در نمایش نظرات رخ داده است!'),
                      );
                    }, (commentList) {
                      if (commentList.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Center(child: Text('نظری وجود ندارد')),
                        );
                      }
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          (commentList[index]
                                                  .username
                                                  .isNotEmpty)
                                              ? commentList[index].username
                                              : 'کاربر',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.end,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          commentList[index].text,
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child:
                                        (commentList[index].avatar.isNotEmpty)
                                            ? CachedImage(
                                                imageUrl: commentList[index]
                                                    .userThumbnailUrl,
                                              )
                                            : Image.asset(
                                                'assets/images/avatar.png'),
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: commentList.length,
                        ),
                      );
                    })
                  }
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                          labelText: 'نظر خود را بنویسید...',
                          labelStyle: TextStyle(
                            fontFamily: 'sm',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: CustomColor.blue, width: 2),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: const Text(
                        'ارسال نظر',
                        style: TextStyle(
                          fontFamily: 'sm',
                          fontSize: 20.0,
                        ),
                      ),
                      onPressed: () {
                        if (textController.text.isEmpty) {
                          return;
                        }
                        context.read<CommentBloc>().add(
                              CommentPostEvent(
                                productId,
                                textController.text,
                              ),
                            );
                        textController.text = '';
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ProductProperties extends StatefulWidget {
  final List<Property> productPropertiyList;
  const ProductProperties(
    this.productPropertiyList, {
    Key? key,
  }) : super(key: key);

  @override
  State<ProductProperties> createState() => _ProductPropertiesState();
}

class _ProductPropertiesState extends State<ProductProperties> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
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
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.only(left: 44, right: 44, top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: CustomColor.grey, width: 1),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.productPropertiyList.length,
                    itemBuilder: (context, index) {
                      var property = widget.productPropertiyList[index];
                      return Row(
                        children: [
                          Flexible(
                            child: Text(
                              '${property.title} : ${property.value}',
                              style: const TextStyle(
                                  fontFamily: 'SB', fontSize: 14, height: 1.8),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  final String productDescription;
  const ProductDescription(
    this.productDescription, {
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
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
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.only(left: 44, right: 44, top: 20),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: CustomColor.grey, width: 1),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.productDescription,
                    style: const TextStyle(
                        fontFamily: 'SM', fontSize: 16, height: 1.8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  final List<ProductVariant> productVariantList;
  const VariantContainerGenerator(
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
  final ProductVariant productVariant;
  const VariantGeneratorChild(this.productVariant, {super.key});

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
  final List<ProductImage> productImageList;
  final String defaultProductThumbnail;
  int selectedItem = 0;
  GalleryWidget(
    this.defaultProductThumbnail,
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
                        height: 200,
                        width: 200,
                        child: CachedImage(
                          imageUrl: (widget.productImageList.isEmpty)
                              ? widget.defaultProductThumbnail
                              : widget.productImageList[widget.selectedItem]
                                  .imageUrl,
                        ),
                      ),
                      const Spacer(),
                      Image.asset('assets/images/icon_favorite.png'),
                    ],
                  ),
                ),
              ),
              if (widget.productImageList.isNotEmpty) ...{
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
              }
            ],
          ),
        ),
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  final Product product;
  const AddToBasketButton(this.product, {Key? key}) : super(key: key);

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
            child: GestureDetector(
              onTap: () {
                context.read<ProductBloc>().add(ProductAddToBasket(product));
                context.read<BasketBloc>().add(BasketFetchFromHiveEvent());
              },
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
                    const Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
  final List<Variant> variantsList;
  const ColorVariantList(this.variantsList, {super.key});

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.variantsList.length,
          itemBuilder: (context, index) {
            String variantColors = 'ff${widget.variantsList[index].value}';
            int hexColor = int.parse(variantColors, radix: 16);
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  border: (selectedIndex == index)
                      ? Border.all(
                          width: 2,
                          color: CustomColor.blueIndicator,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        )
                      : Border.all(width: 2, color: Colors.white),
                  color: Color(hexColor),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class StorageVariantList extends StatefulWidget {
  final List<Variant> storageVariants;
  const StorageVariantList(this.storageVariants, {super.key});

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.storageVariants.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 26,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: (selectedIndex == index)
                      ? Border.all(color: CustomColor.blueIndicator, width: 2)
                      : Border.all(color: CustomColor.grey, width: 0),
                ),
                child: Center(
                  child: Text(
                    widget.storageVariants[index].value,
                    style: const TextStyle(fontFamily: 'SM', fontSize: 12),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
