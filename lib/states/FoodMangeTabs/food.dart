import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/models/product_model.dart';
import 'package:fooddelivery/utility/app_controller.dart';
import 'package:fooddelivery/utility/app_service.dart';
import 'package:fooddelivery/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:fooddelivery/utility/my_dialog.dart';
import 'package:fooddelivery/widgets/show_images.dart';
import 'package:fooddelivery/widgets/show_progress.dart';
import 'package:fooddelivery/widgets/show_titles.dart';
import 'package:fooddelivery/widgets/widget_image_network.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Food extends StatefulWidget {
  const Food({Key? key}) : super(key: key);

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  bool load = true;
  bool? haveData;
  List<ProductModel> productModel = [];

  @override
  void initState() {
    super.initState();
    // loadValueFromAPI();
    processReadProduct();
  }

  void processReadProduct() {
    AppService().readProduct().then((value) {
      setState(() {
        load = false;
      });
    });
  }

  Future<Null> loadValueFromAPI() async {
    if (productModel.length != 0) {
      productModel.clear();
    } else {}
    SharedPreferences preference = await SharedPreferences.getInstance();

    String res_id = preference.getString('res_id')!;
    String apiGetProductWhereUserID =
        '${MyConstant.domain}/getProductWhereUser.php?isAdd=true&res_id=$res_id';
    await Dio().get(apiGetProductWhereUserID).then((value) {
      if (value.toString() == 'null') {
        //No data
        setState(() {
          load = false;
          haveData = false;
        });
      } else {
        //Have Data
        for (var item in json.decode(value.data)) {
          ProductModel model = ProductModel.fromMap(item);

          setState(() {
            load = false;
            haveData = true;
            productModel.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('productModels --> ${appController.productModels.length}');
          return Scaffold(
            body: load
                ? const ShowProgress()
                : ((appController.productModels.isEmpty) ||
                        (appController.categoryModelforListProducts.isEmpty))
                    ? const SizedBox()
                    : ListView.builder(
                        itemCount: appController.productModels.length,
                        itemBuilder: (context, index) => Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: WidgetImageNetwork(
                                url:
                                    '${MyConstant.domain}${appController.productModels[index].food_image}',
                                width: 120,
                                height: 120,
                                boxFit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShowTitles(
                                      title: appController
                                          .productModels[index].food_name,
                                      textStyle: MyConstant().h2Style()),
                                  ShowTitles(
                                      title:
                                          'ราคา ${appController.productModels[index].food_price} บาท',
                                      textStyle: MyConstant().h3Style()),
                                  appController
                                          .categoryModelforListProducts.isEmpty
                                      ? const SizedBox()
                                      : ShowTitles(
                                          title: appController
                                              .categoryModelforListProducts[
                                                  index]
                                              .cate_name,
                                          textStyle: MyConstant().h3Style()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              backgroundColor: MyConstant.dark,
              onPressed: () =>
                  Navigator.pushNamed(context, MyConstant.routeCreateFood)
                      .then((value) {
                AppService().readProduct();
              }),
              child: const Icon(Icons.add),
            ),
          );
        });
  }

  String createUrl(String string) {
    //String result = string.substring(1, string.length - 1);
    // List<String> strings = result.split(',');
    String url = '${MyConstant.domain}/api_numfu/api_restaurant}';
    return url;
  }

  ListView BuildListView(BoxConstraints constraints) {
    return ListView.builder(
      itemCount: productModel.length,
      itemBuilder: (context, index) => Card(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              width: constraints.maxWidth * 0.5 - 4,
              height: constraints.maxWidth * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ShowTitles(
                    title: productModel[index].food_name,
                    textStyle:
                        TextStyle(fontFamily: 'MN MINI Bold', fontSize: 20),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.5,
                    height: constraints.maxWidth * 0.4,
                    // child: CachedNetworkImage(
                    //   fit: BoxFit.cover,
                    //   imageUrl: createUrl(productModel[index].food_img),
                    //   placeholder: (context, url) => ShowProgress(),
                    //   errorWidget: (context, url, error) =>
                    //       ShowImages(path: MyConstant.food_imgDefault),
                    // ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(4),
              width: constraints.maxWidth * 0.5 - 4,
              height: constraints.maxWidth * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowTitles(
                      title: 'ราคา ${productModel[index].food_price} บาท',
                      textStyle:
                          TextStyle(fontFamily: 'MN MINI Bold', fontSize: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            print('## You Click Edit');
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => EditProduct(
                            //         productModel: productModel[index],
                            //       ),
                            //     )).then((value) => loadValueFromAPI());
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                            size: 36,
                            color: MyConstant.dark,
                          )),
                      IconButton(
                          onPressed: () {
                            // print('## You Click Delete from index = $index');
                            // confirmDialogDelete(productModel[index]);
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            size: 36,
                            color: MyConstant.dark,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row BuildNextPage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          width: size * 0.9,
          height: 48,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle(),
            onPressed: () {
              Navigator.pushNamed(context, MyConstant.routeCreateFood);
            },
            child: Text(
              'เพิ่มเมนูใหม่',
              style: TextStyle(
                fontSize: 20,
                fontFamily: "MN MINI",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
