import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/brands/brand_show_case.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/brand_controller.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});


   final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {

        ///
        const loader = Column(
          children: [
            TListTileShimmer(),
            SizedBox(height: TSizes.spaceBtwItems),
            TBoxesShimmer(),
            SizedBox(height: TSizes.spaceBtwItems)
          ],
        );
        final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot:snapshot,loader:loader);
        if(widget != null) return widget;


        final brands = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            itemBuilder: (_, index){
            final brand =brands[index];
            return FutureBuilder(
              future: controller.getBrandProducts(brandId: brand.id ,limit: 3),
              builder: (context, snapshot) {


                ///
                final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot:snapshot, loader:loader);
                if(widget != null) return widget;

                ///
                final products = snapshot.data!;


                return  TBrandShowcase(brand: brand, images: products.map((e) => e.thumbnail).toList());
              }
            );

            },
          );
      }
    );
  }
}
