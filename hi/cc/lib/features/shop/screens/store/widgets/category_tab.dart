import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:izistock/common/widgets/layouts/grid_layout.dart';
import 'package:izistock/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:izistock/common/widgets/texts/section_heading.dart';
import 'package:izistock/features/shop/screens/all_products/all_products.dart';
import 'package:izistock/features/shop/screens/store/widgets/category_brands.dart';

import '../../../../../common/widgets/brands/brand_show_case.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/category_controller.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});
  // corrected super.key
     final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding( // corrected the placement of Padding and Column
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Brands
              CategoryBrands(category: category),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Products
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {


                  ///
                  final response = TCloudeHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: const TVerticalProductShimmer());
                  if(response != null) return response;


                  ///
                  final products = snapshot.data!;


                  return Column(
                    children: [
                      TSectionHeading(
                        title: 'You might like',
                        onPressed: () => Get.to(AllProducts(
                          title: category.name,
                          futureMethode: controller.getCategoryProducts(categoryId: category.id , limit: -1),
                        ))),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        TGridLayout(
                            itemCount: products.length,
                            itemBuilder: (_, index) => const TProductCardVertical(product: products[index])),
                      
                    ],
                  );
                }
              ),

            ],
          ),
        ), // removed the extra closing bracket here
      ],
    );
  }
}
