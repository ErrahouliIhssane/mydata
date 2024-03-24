import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();


   /// Firestore instance for database interactions.
     final _db = FirebaseFirestore.instance;
   /// Get limited featured products
   Future<List<ProductModel>> getFeaturedProducts() async {
     try {
       final snapshot = await _db.collection('Products').where(
           'IsFeatured', isEqualTo: true).Limit(4).get();
       return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
     } on FirebaseException catch (e) {
       throw TFirebaseException(e.code).message;
     } on PlatformException catch (e) {
       throw TPlatformException(e.code).message;
     ｝catch (e) {
     throw 'Something went wrong. Please try again';
     }
   }
   /// get limited featured products
   Future<List<ProductModel>> getAllFeaturedProducts() async {
     try {
     final snapshot = await _db.collection('Products').where(
     'IsFeatured', isEqualTo: true).get();
     return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
     } on FirebaseException catch (e) {
     throw TFirebaseException(e.code).message;
     } on PlatformException catch (e) {
     throw TPlatformException(e.code).message;
     ｝catch (e) {
     throw 'Something went wrong. Please try again';
     }
     }
     /// get limited based on the query
     Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
     try {
     final querySnapshot = await query.get();
     final List<ProductModel>productList = querySnapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
     return productList;
     } on FirebaseException catch (e) {
     throw TFirebaseException(e.code).message;
     } on PlatformException catch (e) {
     throw TPlatformException(e.code).message;
     ｝catch (e) {
     throw 'Something went wrong. Please try again';
     }
     }





     Future<List<ProductModel>> getFavouriteProducts(List<String> productIds) async {
     try {
     final snapshot = await _db.collection('Products').where(FieldPath.documentId,whereIn:productIds).get();
     return snapshot.docs.map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot)).toList();

     } on FirebaseException catch (e) {
     throw TFirebaseException(e.code).message;
     } on PlatformException catch (e) {
     throw TPlatformException(e.code).message;
     ｝catch (e) {
     throw 'Something went wrong. Please try again';
     }
     }





     Future<List<ProductModel>> getProductsForBrand({required String brandId, int Limit = -1}) async {
     try {
     final querySnapshot = limit == -1
             ? await _db.colLection('Products').where('Brand.Id', isEqualTo: brandId).get()
             : await _db.colLection('Products').where('Brand.Id', isEqualTo: brandId).limit(limit).get();

     final products = querySnapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
     return products;
     } on FirebaseException catch (e) {
     throw TRirebaseException(e.code).message;
     } on PlatformException catch (e) {
     throw TPlatformException(e.code).message;
     } catch (e){
     throw'Something ment wrong. Please try again';
     }}


     Future<List<ProductModel>> getProductsForCategory({required String category, int Limit = -1}) async {
     try {
     querySnapshot  productCategoryQuery= limit == -1
     ? await _db.colLection('ProductCategory').where('category.Id', isEqualTo: categoryId).get()
     : await _db.colLection('ProductCategory').where('category.Id', isEqualTo: categoryId).limit(limit).get();

     List<String> productIds = productCategoryQuery.docs.map((doc) => doc['productId"] as String).toList();

     final productsQuery = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();

     List<ProductModel> products = productsQuery.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
     return products;
     } on FirebaseException catch (e) {
     throw TRirebaseException(e.code).message;
     } on PlatformException catch (e) {
     throw TPlatformException(e.code).message;
     } catch (e){
     throw'Something ment wrong. Please try again';
     }}

     }

