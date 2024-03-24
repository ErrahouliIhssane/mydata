import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BrandController extends GetxController{
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featureBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(brandRepository());


  @override
  void onInit(){
    getFeatureBrands();
    super.onInit();
  }

   ///---Load Brands
     Future<void>getFeatureBrands() async {
    try{
      // show loader while loqding brands
      isLoading.value = true;
      
      final brands = await brandRepository.getAllBrands();
      
      allBrands.assignAll(brands);
      
      featureBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(4));

    }catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    } finally{
      // stop loader

      isLoading.value=false;
    }
     }

     ///-- Get Brands for Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try{
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    }catch (e){
      TLoaders.errorSnackBar(title : 'Oh Snap!' , message:e.toString());
      return [];
    }
  }
      /// Get Brand specific products from your data source
     Future<List<ProductModel>> getBrandProducts(String brandId , int limit = -1}) async {
    try{
      final products = await ProductRepository.instance.getproductsForBrand(brandId: brandId, limit : limit);
      return products;
    }catch (e){
      TLoaders.errorSnackBar(title : 'Oh Snap!' , message:e.toString());
      return [];
    }
     }
}

