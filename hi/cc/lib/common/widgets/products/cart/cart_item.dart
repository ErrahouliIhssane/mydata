import 'package:flutter/material.dart';
import 'package:izistock/common/widgets/images/t_rounded_image.dart';
import 'package:izistock/common/widgets/texts/product_title_text.dart';
import 'package:izistock/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:izistock/utils/constants/enums.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///image
        TRoundedImage(
          imageUrl: TImages.promoBanner1,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
          onPressed: () {},
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        ///title price sizes
        const Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TBrandTitleWithVerifiedIcon(
              title: 'Nike',
              maxLines: 1,
              brandTextSizes: TextSizes.medium,
              brandTextSize: TextSizes.small,
            ),
            Flexible(
                child: TProductTitleText(
                    title: 'Black Sports shoes', maxLines: 1)),

            ///attributes
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: 'Color',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'Green',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'Size',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'UK 08',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        )),
      ],
    );
  }
}
