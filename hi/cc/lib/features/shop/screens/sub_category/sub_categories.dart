import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:izistock/common/widgets/images/t_rounded_image.dart';
import 'package:izistock/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:izistock/common/widgets/texts/section_heading.dart';
import 'package:izistock/features/shop/controllers/category_controller.dart';
import 'package:izistock/features/shop/screens/all_products/all_products.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: AppBar(title: Text(category.name),showBackArrow:true), // Set the title here),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Banner
              const TRoundedImage(width: double.infinity, imageUrl: TImages.promoBanner1, applyImageRadius: true),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Sub Categories
              FutureBuilder(
                future: controller.getSubCategories(category.id),
                builder: (context, snapshot) {


                  ///
                  const loader = THorizontalProductShimmer();
                  final widget = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  ///
                  final subCategories = snapshot.data!;

                  ///
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {

                      ///
                      final subCategory = subCategories[index];
                      return FutureBuilder(
                        future: controller.getCategoryProducts(categoryId: subCategory.id),
                        builder: (context, snapshot) {

                          ///
                          final widget = TCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot, loader: loader);
                          if (widget != null) return widget;

                          ///
                          final products = snapshot.data!;



                          return Column(
                            children: [
                              TSectionHeading(
                                  title: subCategory.name, onPressed: () => Get.to(
                                  () => AllProducts(
                                      title: subCategory.name,
                                      futureMethode: controller.getCategoryProducts(categoryId: subCategory.id, limit: -1),
                                  )
                              ),
                              ),
                              // Add onPressed function here),
                              const SizedBox(height: TSizes.spaceBtwSections / 2),

                              // Horizontal Product Cards
                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: products.length,
                                  separatorBuilder: (context, index) =>
                                  const SizedBox(width: TSizes.spaceBtwItems),
                                  itemBuilder: (context,
                                      index) =>  TProductCardHorizontal(product : products[index]),
                                ),
                              ),

                              const SizedBox(height: TSizes.spaceBtwSections),
                            ],
                          );
                        }
                      );
                    },
                  );
                } ),
            ],
          ),
        ),
      ),
    );
  }
}
