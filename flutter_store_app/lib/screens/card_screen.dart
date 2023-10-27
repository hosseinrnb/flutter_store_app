import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/bloc/basket/basket_bloc.dart';
import 'package:flutter_store_app/bloc/basket/basket_event.dart';
import 'package:flutter_store_app/bloc/basket/basket_state.dart';
import 'package:flutter_store_app/constants/color.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_store_app/util/extensions/int_extension.dart';
import 'package:flutter_store_app/util/extensions/string_extension.dart';
import 'package:flutter_store_app/widgets/cached_image.dart';

import '../data/model/card_item.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreen,
      body: SafeArea(
        child: Center(
          child: BlocBuilder<BasketBloc, BasketState>(
            builder: (context, state) {
              return Stack(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 16),
                                Image.asset(
                                    'assets/images/icon_apple_blue.png'),
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
                      if (state is BasketDataFetchedState) ...{
                        state.basketItemList.fold((l) {
                          return SliverToBoxAdapter(
                            child: Text(l),
                          );
                        }, (r) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return CardItem(r[index], index);
                              },
                              childCount: r.length,
                            ),
                          );
                        })
                      },
                      const SliverPadding(padding: EdgeInsets.only(bottom: 50)),
                    ],
                  ),
                  if (state is BasketDataFetchedState) ...{
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 44,
                        vertical: 10,
                      ),
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
                          child: Text(
                            ' مبلغ نهایی: ${state.basketFinalPrice.convertToPrice()} تومان',
                            style: const TextStyle(
                              fontFamily: 'SB',
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            context
                                .read<BasketBloc>()
                                .add(BasketPaymentInitEvent());
                            context
                                .read<BasketBloc>()
                                .add(BasketPaymentRequestEvent());
                          },
                        ),
                      ),
                    )
                  },
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final BasketItem basketItem;
  final int index;
  const CardItem(
    this.basketItem,
    this.index, {
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
                  SizedBox(
                    height: 105,
                    width: 80,
                    child: CachedImage(imageUrl: basketItem.thumbnail),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            basketItem.name,
                            style: const TextStyle(
                              fontFamily: 'SB',
                              fontSize: 15.0,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            '18 ماه گارانتی مدیا پردازش',
                            style: TextStyle(
                              color: CustomColor.grey,
                              fontFamily: 'SM',
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                basketItem.price.convertToPrice(),
                                style: const TextStyle(
                                  color: CustomColor.grey,
                                  fontFamily: 'SM',
                                  fontSize: 12.0,
                                ),
                              ),
                              const Text(
                                'تومان ',
                                style: TextStyle(
                                  color: CustomColor.grey,
                                  fontFamily: 'SM',
                                  fontSize: 12.0,
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 6),
                                  child: Text(
                                    '%${basketItem.persent!.round().toString()}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'SB',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 10,
                            children: [
                              const OptionCheap(
                                'آبی',
                                color: '4287f5',
                              ),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<BasketBloc>()
                                      .add(BasketRemoveProductEvent(index));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: CustomColor.grey, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'assets/images/icon_delete.png',
                                        ),
                                        const SizedBox(width: 5),
                                        const Text(
                                          'حذف',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'SM',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                children: [
                  Text(
                    basketItem.realPrice.convertToPrice(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'SB',
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'تومان',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'SB',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionCheap extends StatefulWidget {
  final String? color;
  final String title;
  const OptionCheap(
    this.title, {
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  State<OptionCheap> createState() => _OptionCheapState();
}

class _OptionCheapState extends State<OptionCheap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.grey, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.color != null) ...{
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.parseToColor(),
                ),
              ),
            },
            const SizedBox(width: 6),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'SM',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
