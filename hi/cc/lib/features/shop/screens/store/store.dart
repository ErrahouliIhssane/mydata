import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:izistock/common/widgets/brands/brand_card.dart';
import 'package:izistock/features/shop/controllers/brand_controller.dart';
import 'package:izistock/features/shop/screens/brand/all_brands.dart';
import 'package:izistock/features/shop/screens/store/widgets/category_tab.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;



    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: const TAppBar(),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 440,
                automaticallyImplyLeading: false,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.black
                    : TColors.white,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const TSearchContainer(
                        text: 'Search in store',
                        showBorder: true,
                        showBackGround: false,
                        padding: EdgeInsets.zero,
                        showBackground: false,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      TSectionHeading(
                        title: 'Featured Brands',
                        onPressed: () => Get.to(() => const AllBrandsScreen())),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                      
                      Obx(
                        () {
                          if(brandController.isLoading.value) return TBrandShimer();

                          if(brandController.featureBrands.isEmpty){
                            return Center(
                              child: Text('No Data Found',style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
                          }
                          return TGridLayout(
                            itemCount: brandController.featureBrands.length,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final brand = brandController.featureBrands[index];
                              return TBrandCard(showBorder: true , brand:null,);


                              // In the Backend Tutorial, we will pass the Each Brand & onPress Event also.
                              return const TBrandCard(showBorder: false);
                            },
                          );
                        },
                      ),
                  ],
                  ),
                ),
                bottom: TTabBar(tabs : categories.map((category) => Tab(child: Text(category.name))).toList()),
              ),
              // SliverPersistentHeader(
              //   delegate: _SliverAppBarDelegate(
              //     TabBar(
              //       isScrollable: true,
              //       indicatorColor: Colors.amber,
              //       unselectedLabelColor: Colors.teal,
              //       labelColor: THelperFunctions.isDarkMode(context)
              //           ? Colors.white
              //           : Colors.amber,
              //       tabs: const [
              //         Tab(child: Text('Sports')),
              //         Tab(child: Text('Furniture')),
              //         Tab(child: Text('Electroniques')),
              //         Tab(child: Text('Clothes')),
              //         Tab(child: Text('Cosmetics')),
              //       ],
              //     ),
              //   ),
              //   pinned: true,
              // ),
            ];
          },
          body: TabBarView(children: categories.map((category) => TCategoryTab(category: category)).toList()), // Replace with the content of your screen
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
