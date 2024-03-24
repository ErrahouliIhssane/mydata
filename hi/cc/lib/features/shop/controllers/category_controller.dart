import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:izistock/features/shop/screens/all_products/product_repository.dart';

class CategoryController extends GetxController {
   static CategoryController get instance => Get.find;


  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;


  @override
  void onInit() {
  fetchCategories();
  super.onInit();}

   Future<void> fetchCategories() async {
  try {
       // Show loader while loading categories
   isLoading.value = true;
      // Fetch categories from data source (Firestore, API, etc.)
    final categories = await _categoryRepository.getAllCategories();
      // Update the categories list
    allCategories.assignAll(categories);
       // Filter featured categories
  featuredCategories.assignAll(allCategories.where((category) => Category.isFeatured && category.parentId.isEmpty).take(8).toList());
       } catch (e) {
     TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
     }finally {
    // Remove Loader
         isLoading.value = false;}}

  ///Load selected category data
   Future<List<CategoryModel>> getSubCategories({String categoryId }) async {

     try{
       final subCategories = await _categoryRepository.getSubCategories(categoryId);
       return subCategories;
     }catch (e){
       TLoaders.errorSnackBar(title: 'Oh Snap!',message : e.toString());
       return [];
     }

   }




   /// get category or sub
   Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4 }) async {
    try{
    final products = await ProductRepository.instance.getProductsForCategory(categoryId:categoryId, limit:limit);
    return products;
   }catch (e){
      TLoaders.errorSnackBar(title: 'Oh Snap!',message : e.toString());
      return [];
    }

}