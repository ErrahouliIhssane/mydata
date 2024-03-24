import 'dart:html';
import 'package:flutter/cupertino.dart';

class ProductCategoryModel{
  final String productId;
  final String categoryId;

  ProductCategoryModel({
    required this.productId,
    required this.categoryId,
  });
  Map<String, dynamic> toJson(){
    return{
      'brandId' : productId,
      'categoryId': categoryId,
    };
  }
  factory ProductCategoryModel.fromSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String , dynamic>;
    return ProductCategoryModel(
      productId: data ['productId'] as String,
      categoryId: data ['categoryId'] as String,);
  }
}