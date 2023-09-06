import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/bloc/home/home_bloc.dart';
import 'package:flutter_store_app/bloc/home/home_event.dart';
import 'package:flutter_store_app/bloc/home/home_state.dart';
import 'package:flutter_store_app/constants/color.dart';
import 'package:flutter_store_app/data/model/banner.dart';
import 'package:flutter_store_app/data/model/category.dart';
import 'package:flutter_store_app/data/model/product.dart';
import 'package:flutter_store_app/widgets/product_item.dart';
import 'package:flutter_store_app/widgets/banner_slider.dart';
import 'package:flutter_store_app/widgets/horizontal_category.dart';
import 'package:flutter_store_app/widgets/loading_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreen,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return _getHomeScreenContent(state, context);
          },
        ),
      ),
    );
  }
}

Widget _getHomeScreenContent(HomeState state, BuildContext context) {
  if (state is HomeLoadingState) {
    return const LoadingIndicatorWidget();
  } else if (state is HomeRequestSuccessState) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(HomeGetInitilizeData());
      },
      child: CustomScrollView(
        slivers: [
          const GetSearchBox(),
          state.bannerList.fold(
            (l) {
              return SliverToBoxAdapter(
                child: Text(l),
              );
            },
            (r) {
              return GetBanners(r);
            },
          ),
          const GetCategoryListText(),
          state.categoryList.fold(
            (l) {
              return SliverToBoxAdapter(
                child: Text(l),
              );
            },
            (r) {
              return GetCategoryList(r);
            },
          ),
          const GetBestSellerTitle(),
          state.bestSellerProductList.fold(
            (l) {
              return SliverToBoxAdapter(
                child: Text(l),
              );
            },
            (r) {
              return GetBestSellerProducts(r);
            },
          ),
          const GetMostViewedTitle(),
          state.hottestProductList.fold(
            (l) {
              return SliverToBoxAdapter(
                child: Text(l),
              );
            },
            (r) {
              return GetMostViewedProducts(r);
            },
          ),
        ],
      ),
    );
  } else {
    return const Center(
      child: Text('خطایی رخ داده!'),
    );
  }
}

class GetMostViewedProducts extends StatelessWidget {
  final List<Product> mvproductList;
  const GetMostViewedProducts(
    this.mvproductList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(right: 44, bottom: 10),
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mvproductList.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ProductItem(mvproductList[index]),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class GetMostViewedTitle extends StatelessWidget {
  const GetMostViewedTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(right: 44, left: 44, bottom: 20, top: 32),
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
              style: TextStyle(
                  fontFamily: 'SB', color: CustomColor.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class GetBestSellerProducts extends StatelessWidget {
  final List<Product> bsproductList;
  const GetBestSellerProducts(
    this.bsproductList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(right: 44),
          child: SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: bsproductList.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ProductItem(bsproductList[index]),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class GetBestSellerTitle extends StatelessWidget {
  const GetBestSellerTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
              style: TextStyle(
                  fontFamily: 'SB', color: CustomColor.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class GetCategoryListText extends StatelessWidget {
  const GetCategoryListText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(right: 44, left: 44, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'دسته بندی',
              style: TextStyle(
                  fontFamily: 'SB', color: CustomColor.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class GetCategoryList extends StatelessWidget {
  final List<Category> listCategories;
  const GetCategoryList(
    this.listCategories, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(right: 44),
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listCategories.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: CategoryHorizontalItem(listCategories[index]),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class GetBanners extends StatelessWidget {
  final List<MyBanner> mybanner;
  const GetBanners(
    this.mybanner, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: BannerSlider(mybanner),
      ),
    );
  }
}

class GetSearchBox extends StatelessWidget {
  const GetSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 44, right: 44, top: 20, bottom: 10),
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
    );
  }
}
