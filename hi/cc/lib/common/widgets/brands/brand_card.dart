import 'package:flutter/material.dart';
import 'package:izistock/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:izistock/common/widgets/images/t_circular_image.dart';
import 'package:izistock/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:izistock/utils/constants/colors.dart';
import 'package:izistock/utils/constants/image_strings.dart';
import 'package:izistock/utils/helpers/helper_functions.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    this.onTap,
    required this.showBorder,
  });

  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(TSizes.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: TCircularImage(
                isNetWorkImage: false,
                image: TImages.darkAppLogo,
                backgroundColor: Colors.transparent,
                overlayColor: isDark ? TColors.white : TColors.black,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            const Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TBrandTitleWithVerifiedIcon(
                  title: 'Nike',
                  brandTextSizes: TextSizes.large,
                  maxLines: 3,
                  brandTextSize: TextSizes.medium,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
