import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:izistock/features/shop/screens/all_products/product_repository.dart';
import 'package:izistock/utils/local_storage/storage_utility.dart';

class FavouritesController extends GetxController{

  static FavouritesController get instance => Get.find();

  ///Variables
  final favorites = <String, bool>{}.obs;


   @override
  void onInit(){
     super.onInit();
     initFavorites();
   }
   //
   Future<void> initFavorites() async{
     final json = TLocalStorage.instance().readData('favorites');
     if(json != null ){
       final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
       favorites.assignAll(storedFavorites.map((key, value) => MapEntry(key, value as bool)));
     }

   }
   bool isFavourite(String productId){
     return favorites[productId] ?? false;

   }
   void toggleFavoriteProduct(String productId){
     if(favorites.containsKey(productId)) {
       favorites[productId] = true;
       saveFavoritesToStorage();
       TLoaders.customToast(message: 'Product has been added to the WishList.');
     }else{
       TLocalStorage.instance().removeData(productId);
       favorites.remove(productId);
       saveFavoritesToStorage();
       favorites.refresh();
       TLoaders.customToast(message: 'Product has been added to the WishList.');

     }
   }

   void saveFavoritesToStorage(){
     final encodedFavorites = json.encode(favorites);
     TLocalStorage.instance().saveData('favorites', encodedFavorites);
   }


  Future<List<ProductModel>> favoriteProducts () async{
    return await ProductRepository.instance.getFavouriteProducts(favorites.keys.toList());
}


}