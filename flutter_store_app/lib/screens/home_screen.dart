import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/bloc/home/home_bloc.dart';
import 'package:flutter_store_app/bloc/home/home_event.dart';
import 'package:flutter_store_app/bloc/home/home_state.dart';
import 'package:flutter_store_app/constants/color.dart';
import 'package:flutter_store_app/data/model/banner.dart';
import 'package:flutter_store_app/widgets/product_item.dart';
import 'package:flutter_store_app/widgets/banner_slider.dart';
import 'package:flutter_store_app/widgets/horizontal_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeGetInitilizeData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundScreen,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                const _getSearchBox(),
                if (state is HomeLoadingState) ...[
                  const SliverToBoxAdapter(
                    child: CircularProgressIndicator(),
                  ),
                ],
                if (state is HomeRequestSuccessState) ...[
                  state.bannerList.fold(
                    (l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    },
                    (r) {
                      return _getBanners(r);
                    },
                  ),
                ],
                _getCategoryListText(),
                _getCategoryList(),
                _getBestSellerTitle(),
                _getBestSellerProducts(),
                _getMostViewedTitle(),
                _getMostViewedProducts(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _getMostViewedProducts extends StatelessWidget {
  const _getMostViewedProducts({
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
    );
  }
}

class _getMostViewedTitle extends StatelessWidget {
  const _getMostViewedTitle({
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

class _getBestSellerProducts extends StatelessWidget {
  const _getBestSellerProducts({
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
    );
  }
}

class _getBestSellerTitle extends StatelessWidget {
  const _getBestSellerTitle({
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

class _getCategoryListText extends StatelessWidget {
  const _getCategoryListText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44, left: 44, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
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

class _getCategoryList extends StatelessWidget {
  const _getCategoryList({
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
              itemCount: 10,
              itemBuilder: ((context, index) {
                return const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: CategoryHorizontalItem(),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _getBanners extends StatelessWidget {
  List<MyBanner> mybanner;
  _getBanners(
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

class _getSearchBox extends StatelessWidget {
  const _getSearchBox({
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
