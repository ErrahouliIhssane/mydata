import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:izistock/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:izistock/common/widgets/images/t_rounded_image.dart';
import 'package:izistock/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:izistock/common/widgets/texts/product_title_text.dart';
import 'package:izistock/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:izistock/utils/constants/enums.dart';
import 'package:izistock/utils/constants/image_strings.dart';
import 'package:izistock/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../icons/t_circular_icon.dart';
import '../../texts/product_price_text.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key, required this.product});

  // get dark => null;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    final dark =THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);


    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: dark ? TColors.darkerGrey : TColors.softGrey,
      ),
      child: Row(
        children: [
          TRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.dark : TColors.white,
            child: Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: TRoundedImage(
                    imageUrl: TImages.thumbnail,
                    applyImageRadius: true,isNetworkImage: true,),

                  ),
                 ///
                if(salePercentage != null)
                 Positioned(
                  top: 12,
                  child: TRoundedContainer(
                    radius: TSizes.sm,
                    backgroundColor: TColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.sm, vertical: TSizes.xs),
                    child: Text(
                      '25%', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black)),
                      // .apply(color: TColors.black),
                    ),
                  ),

                 Positioned(
                  top: 0,
                  right: 0,
                  child: TFavouriteIcon(productId : product.id),
                ),
              ],
            ),
          ),
          //Details
         SizedBox(
            width: 172,
            child: Padding(
              padding:const EdgeInsets.only(top : TSizes.sm,left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TProductTitleText(title: product.title, smallSize: true),
                          SizedBox(height: TSizes.spaceBtwItems / 2),
                          TBrandTitleWithVerifiedIcon(title: product.brand!.name),
                        ],
                      ),
                      const Spacer(),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          children:[
                            if(product.productType == ProductType.single.toString() && product.salePrice > 0)
                              Padding(
                                padding : const EdgeInsets.only(left: TSizes.sm),
                                child :Text(
                                  product.price.toString(),
                                  style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                                ),
                              ),
                            Padding(
                              padding : const EdgeInsets.only(left: TSizes.sm),
                              child : TProductPriceText(price: controller.getProductPrice(product)),
                            ),
                          ],
                        ),
                      ),



                          ///
                          Container(
                            decoration: const BoxDecoration(
                              color: TColors.dark,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(TSizes.cardRadiusMd),
                                bottomRight: Radius.circular(TSizes.productImageRadius),
                              ),
                            ),
                            child: const SizedBox(
                              width: TSizes.iconLg * 1.2,
                              height: TSizes.iconLg * 1.2,
                              child: Center(child: Icon(Iconsax.add, color:TColors.white)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

              ),
            ),

        ],
      ),
    );
  }
}
