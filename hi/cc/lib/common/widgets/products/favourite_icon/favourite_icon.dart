import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:izistock/common/widgets/icons/t_circular_icon.dart';

import '../../../../features/shop/controllers/product/favourites_controller.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(FavouritesController());
    return Obx(() => const TCircularIcon(
        icon: Iconsax.heart5 , color : Colors.red);
  }
}
