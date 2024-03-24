import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon,
    this.showBackGround=true,
    this.showBorder=true,
    this.onTap,
    required bool searchInStore,
    required bool showBackground,
    required EdgeInsetsGeometry padding,

  });

  final String text;
  final IconData? icon;
  final bool showBackGround, showBorder;
  final VoidCallback? onTap;



  @override
  Widget build(BuildContext context) {

    final dark =THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
        child:Container(
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color: showBackGround? dark? TColors.dark:TColors.light:Colors.transparent,
            borderRadius:BorderRadius.circular(TSizes.cardRadiusLg),
            border:  showBorder? Border.all(color: Colors.grey):null,
          ),
          child: Row(
            children: [
              const Icon(Iconsax.search_normal, color:TColors.dark),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text('Search in Store', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),

      ),
    );
  }
}

