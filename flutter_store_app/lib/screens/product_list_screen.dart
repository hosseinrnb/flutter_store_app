import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/bloc/categoryProduct/category_product_bloc.dart';
import 'package:flutter_store_app/bloc/categoryProduct/category_product_event.dart';
import 'package:flutter_store_app/bloc/categoryProduct/category_product_state.dart';
import 'package:flutter_store_app/constants/color.dart';
import 'package:flutter_store_app/widgets/product_item.dart';

import '../data/model/category.dart';

class ProductListScreen extends StatefulWidget {
  Category category;
  ProductListScreen(this.category, {Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(context)
        .add(CategoryProductInit(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductBloc, CategoryProductState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CustomColor.backgroundScreen,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
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
                              child: Text(
                                widget.category.title!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'SB',
                                  color: CustomColor.blue,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset('assets/images/icon_back.png'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (state is CategoryProductLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                },
                if (state is CategoryProductResponseSuccessState) ...{
                  state.ProductListByCategory.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, (r) {
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 30,
                          childAspectRatio: 2 / 2.8,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ProductItem(r[index]);
                          },
                          childCount: r.length,
                        ),
                      ),
                    );
                  })
                },
              ],
            ),
          ),
        );
      },
    );
  }
}
