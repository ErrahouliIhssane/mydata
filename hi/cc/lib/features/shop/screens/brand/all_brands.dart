import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:izistock/common/widgets/appbar/appbar.dart';
import 'package:izistock/common/widgets/brands/brand_card.dart';
import 'package:izistock/common/widgets/layouts/grid_layout.dart';
import 'package:izistock/common/widgets/texts/section_heading.dart';
import 'package:izistock/features/shop/controllers/brand_controller.dart';
import 'package:izistock/features/shop/screens/brand/brand_products.dart';

import '../../../../utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: const TAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Heading
              const TSectionHeading(title: 'Brands',showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Brands
              Obx(
                    () {
                  if(brandController.isLoading.value) return TBrandShimer();

                  if(brandController.allBrands.isEmpty){
                    return Center(
                        child: Text('No Data Found',style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
                  }
                  return TGridLayout(
                    itemCount: brandController.allBrands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (_, index) {
                      final brand = brandController.allBrands[index];
                      return TBrandCard(showBorder: true , brand:brand ,
                        onTap: () => Get.to(() =>  BrandProducts(brand: brand,)),
                      );


                      // In the Backend Tutorial, we will pass the Each Brand & onPress Event also.
                      return const TBrandCard(showBorder: false);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
