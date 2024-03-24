import 'package:flutter/material.dart';
import 'package:izistock/common/widgets/texts/t_brand_title_text.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  const TBrandTitleWithVerifiedIcon({
    super.key, // Added Key? key here
    required this.title,
    required this.maxLines,
    required this.brandTextSizes,
    this.textColor,
    this.iconColor = TColors.black,
    this.textAlign = TextAlign.center,
    required TextSizes brandTextSize,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign textAlign;
  final TextSizes brandTextSizes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSizes: brandTextSizes,
          ),
        ),
        const SizedBox(width: TSizes.xs),
        const Icon(Icons.verified, color: TColors.primary, size: TSizes.iconXs),
      ],
    );
  }
}
