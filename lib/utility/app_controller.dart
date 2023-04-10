// ignore_for_file: non_constant_identifier_names

import 'package:fooddelivery/models/category_model.dart';
import 'package:fooddelivery/models/product_model.dart';
import 'package:get/get.dart';

class AppController extends GetxController{

  RxList<String> res_ids = <String>[].obs;
  RxList<CategoryModel> categoryModels = <CategoryModel>[].obs;
  RxList<CategoryModel> categoryModelforListProducts = <CategoryModel>[].obs;
  RxList<CategoryModel?> chooseCategoryModels = <CategoryModel?>[null].obs;
  RxList<ProductModel> productModels = <ProductModel>[].obs;

  
}