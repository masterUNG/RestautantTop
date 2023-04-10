import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/utility/app_controller.dart';
import 'package:fooddelivery/utility/app_service.dart';
import 'package:fooddelivery/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:fooddelivery/utility/my_dialog.dart';
import 'package:fooddelivery/widgets/show_titles.dart';
import 'package:get/get.dart';

class CategoryFood extends StatefulWidget {
  const CategoryFood({super.key});

  @override
  State<CategoryFood> createState() => _CategoryFoodState();
}

class _CategoryFoodState extends State<CategoryFood> {
  @override
  void initState() {
    super.initState();
    AppService().readCategoryWhereResId();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GetX(
            init: AppController(),
            builder: (AppController appController) {
              print(
                  'categoryModels -->>> ${appController.categoryModels.length}');
              return SizedBox(
                width: boxConstraints.maxWidth,
                height: boxConstraints.maxHeight,
                child: Stack(
                  children: [
                    appController.categoryModels.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                            itemCount: appController.categoryModels.length,
                            itemBuilder: (context, index) => ShowTitles(
                                title: appController
                                    .categoryModels[index].cate_name,
                                textStyle: MyConstant().h3Style()),
                          ),
                    Positioned(
                      bottom: 0,
                      child:
                          buildNextPage(size, boxConstraints: boxConstraints),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }

  Widget buildNextPage(double size, {required BoxConstraints boxConstraints}) {
    return SizedBox(
      width: boxConstraints.maxWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            // width: size * 0.9,
            height: 48,
            child: ElevatedButton(
              style: MyConstant().myButtonStyle(),
              onPressed: () {
                Navigator.pushNamed(context, MyConstant.routeCreateCategory)
                    .then((value) {
                  AppService().readCategoryWhereResId();
                });
              },
              child: Text(
                'เพิ่มหมวดหมู่ใหม่',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "MN MINI",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
