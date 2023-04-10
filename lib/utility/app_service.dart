import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fooddelivery/models/category_model.dart';
import 'package:fooddelivery/models/product_model.dart';
import 'package:fooddelivery/utility/app_controller.dart';
import 'package:get/get.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> readProduct() async {
    if (appController.productModels.isNotEmpty) {
      appController.productModels.clear();
      appController.categoryModelforListProducts.clear();
    }

    String urlAPI =
        'https://www.androidthai.in.th/edumall/getProductWhereUser.php?isAdd=true&res_id=${appController.res_ids.last}';
    await Dio().get(urlAPI).then((value) async {
      if (value.toString() != 'null') {
        for (var element in json.decode(value.data)) {
          ProductModel productModel = ProductModel.fromMap(element);
          appController.productModels.add(productModel);

          String url =
              'https://www.androidthai.in.th/edumall/getCatWhereId.php?isAdd=true&cate_id=${productModel.cate_id}';
          await Dio().get(url).then((value) {
            for (var element in json.decode(value.data)) {
              CategoryModel categoryModel = CategoryModel.fromMap(element);
              appController.categoryModelforListProducts.add(categoryModel);
            }
          });
        }
      }
    });
  }

  Future<void> readCategoryWhereResId() async {
    if (appController.categoryModels.isNotEmpty) {
      appController.categoryModels.clear();
      appController.chooseCategoryModels.clear();
      appController.chooseCategoryModels.add(null);
    }

    String path = 'https://www.androidthai.in.th/edumall/getCategory.php';
    await Dio().get(path).then((value) {
      for (var element in json.decode(value.data)) {
        CategoryModel categoryModel = CategoryModel.fromMap(element);
        if (appController.res_ids.last == categoryModel.res_id) {
          appController.categoryModels.add(categoryModel);
        }
      }
    });
  }
}
