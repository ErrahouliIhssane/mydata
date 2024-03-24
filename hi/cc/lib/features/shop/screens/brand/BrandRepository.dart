
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BrandRepository extends GetxController{
  static BrandRepository get instance => Get.find();

  ///Variables
   final _db = FirebaseFireStore.instance;


   ///Get all Categories

    Future<List<BrandModel>> getAllBrands() async{
      try{
        final snapshot =await _db.collection('Brands').get();
        final result =snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
        return result;

      } on FirebaseException catch (e){
        throw TFirebaseException(e.code).message;
      }on FormatException catch (_) {
        throw const TFormatException();
      }on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
      } catch (e){
        throw 'something went wrong while fetching banners'
      }
   }


  Future<List<BrandModel>> getBrandsForCategory(String categoryId ) async{
    try{
      QuerySnapshot brandCategoryQuery = await _db.collection('BrandCategory').where('categoryId' , isEqualTo: categoryId).get();


      List<String> brandsIds = brandCategoryQuery.docs.map((doc) => doc ['brandId'] as String ).toList();


      final brandsQuery = await _db.collection('BrandCategory').where(FieldPath.documentId, whereIn: brandIds).limit(2).get();

      List<brandModel> brands = brandsQuery.docs.map((doc) =>brandModel.fromSnapshot(doc)).toList();


      return brands;


    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }on FormatException catch (_) {
      throw const TFormatException();
    }on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e){
      throw 'something went wrong while fetching banners'
    }
  }

}