import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();


  ///Variables
  final _db = FirebaseFirestore.instance;


  ///get all categories

  Future<List<BrandModel>> getAllBrands() {
    try {
      final snapshot = await _db.collection('brands').get();
      final result = snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();

      return result;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching banners .';
    }
  }





   /// get brands for category


}