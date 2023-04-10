import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:fooddelivery/utility/my_dialog.dart';
import 'package:fooddelivery/widgets/show_titles.dart';
import 'package:image_picker/image_picker.dart';

class CreateAddon extends StatefulWidget {
  const CreateAddon({super.key});

  @override
  State<CreateAddon> createState() => _CreateAddonState();
}

class _CreateAddonState extends State<CreateAddon> {
  String? typeOption;
  String? MoreOprion;
  //----------------------comming soon back end-----------------------------
  final formKey = GlobalKey<FormState>();
  TextEditingController addon_nameController = TextEditingController();
  TextEditingController addon_optionController = TextEditingController();
  // String food_img = '';
  // double? lat, lng;
  // File? file;

  //  Future<Null> Insertdata() async {
  //   String addon_name = addon_nameController.text;
  //   if (file == null) {
  //     processInsertMySQL(
  //       addon_name: addon_name,

  //     );
  //   } else {
  //     String apiSaveImg =
  //         '${MyConstant.domain}/fooddelivery/saveRestaurantImg.php';
  //     int i = Random().nextInt(100000);
  //     String nameRIMG = 'R_Img$i.jpg';
  //     Map<String, dynamic> map = Map();
  //     map['file'] =
  //         await MultipartFile.fromFile(file!.path, filename: nameRIMG);
  //     FormData data = FormData.fromMap(map);
  //     await Dio().post(apiSaveImg, data: data).then((value) {
  //       food_img = '/fooddelivery/RestaurantImg/$nameRIMG';
  //       processInsertMySQL(
  //         addon_name: addon_name,
  //       );
  //     });
  //   }
  // }

  // Future<Null> processInsertMySQL({
  //   String? addon_name,

  // }) async {
  //   print('Process insert data success');
  //   String apiInsertUser =
  //       '${MyConstant.domain}/fooddelivery/insertData.php?isAdd=true&name=$name&lastname=$lastname&phone=$phone&email=$email&password=$password&RestaurantImg=$avata&n_restaurant=$n_restaurant&address=$address&lat=$lat&lng=$lng';
  //   await Dio().get(apiInsertUser).then((value) {
  //     if (value.toString() == 'true') {
  //       Navigator.pushNamed(context, MyConstant.routeAddon);
  //     } else {
  //       MyDialog()
  //           .normalDialog(context, 'Create User Fail !!', 'Please try again');
  //     }
  //   });
  // }
  //---------------------------------------------------
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'เพิ่มตัวเลือกเสริม',
          style: TextStyle(
              color: Colors.black87, fontSize: 36, fontFamily: "MN MINI"),
        ),
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                BuildTitle('ชื่อกลุ่มตัวเลือกเสริม', size),
                BuildNameAddon(size),
                BuildTitle('ตัวเลือกย่อย', size),
                BuildSubTitle('เช่น ไข่มุก เยลลี่ ไข่ดาว ไข่เจียว', size),
                BuildAddonOption(size),
                BuildTitle('รายละเอียดตัวเลือก', size),
                BuildTitle('ลูกค้าจำเป็นต้องเลือกตัวเลือกนี้หรือไม่', size),
                BuildNecessaryOption(),
                BuildUnNecessaryOption(),
                BuildTitle('ลูกค้าสามารถเลือกตัวเลือกได้กี่อย่าง', size),
                BuildOption1More(),
                BuildOptionAllMore(),
                BuildNextPage(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container BuildTitle(String title, double size) {
    return Container(
      width: size * 0.9,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10),
      child: ShowTitles(
        title: title,
        textStyle: TextStyle(
          color: Colors.black87,
          fontFamily: "MN MINI",
          fontSize: 19,
        ),
      ),
    );
  }

  Container BuildSubTitle(String title, double size) {
    return Container(
      width: size * 0.9,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10),
      child: ShowTitles(
        title: title,
        textStyle: TextStyle(
          color: Colors.grey,
          fontFamily: "MN MINI",
          fontSize: 19,
        ),
      ),
    );
  }

    Container BuildNecessaryOption() {
    return Container(
      alignment: Alignment.centerLeft,
      child: RadioListTile(
                  value: 'จำเป็น',
                  groupValue: typeOption,
                  onChanged: (value) {
                    setState(() {
                      typeOption = value;
                    });
                  },
                  title: ShowTitles(
                    title: 'จำเป็น',
                    textStyle:TextStyle(
                      color: Colors.black87,
                      fontFamily: "MN MINI",
                      fontSize: 16,
                    ),
                  ),
                ),
    );
  }

    Container BuildUnNecessaryOption() {
    return Container(
      alignment: Alignment.centerLeft,
      child: RadioListTile(
                  value: 'ไม่จำเป็น',
                  groupValue: typeOption,
                  onChanged: (value) {
                    setState(() {
                      typeOption = value;
                    });
                  },
                  title: ShowTitles(
                    title: 'ไม่จำเป็น',
                    textStyle:TextStyle(
                      color: Colors.black87,
                      fontFamily: "MN MINI",
                      fontSize: 16,
                    ),
                  ),
                ),
    );
  }

  Container BuildOption1More() {
    return Container(
      alignment: Alignment.centerLeft,
      child: RadioListTile(
                  value: '1อย่าง',
                  groupValue: MoreOprion,
                  onChanged: (value) {
                    setState(() {
                      MoreOprion = value;
                    });
                  },
                  title: ShowTitles(
                    title: '1อย่าง',
                    textStyle:TextStyle(
                      color: Colors.black87,
                      fontFamily: "MN MINI",
                      fontSize: 16,
                    ),
                  ),
                ),
    );
  }

    Container BuildOptionAllMore() {
    return Container(
      alignment: Alignment.centerLeft,
      child: RadioListTile(
                  value: 'หลายอย่าง',
                  groupValue: MoreOprion,
                  onChanged: (value) {
                    setState(() {
                      MoreOprion = value;
                    });
                  },
                  title: ShowTitles(
                    title: 'หลายอย่าง',
                    textStyle:TextStyle(
                      color: Colors.black87,
                      fontFamily: "MN MINI",
                      fontSize: 16,
                    ),
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
              // Navigator.pushNamed(context, MyConstant.routeCreateAccount2);
              //Insertdata();
            },
            child: Text(
              'เพิ่มตัวเลือก',
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

  Row BuildNameAddon(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.9,
          child: TextFormField(
            controller: addon_nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกชื่อตัวเลือกเสริม';
              } else {}
            },
            maxLength: 255,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                color: Colors.black87,
                fontFamily: "MN MINI",
                fontSize: 19,
              ),
              hintStyle: TextStyle(
                fontFamily: "MN MINI",
                fontSize: 16,
              ),
              labelText: 'ชื่อตัวเลือก',
              hintText: 'กรุณากรอกชื่อตัวเลือกเสริม',
              contentPadding: EdgeInsets.only(left: 20),
              suffixIcon: IconButton(
                onPressed: () {
                  addon_nameController.clear();
                },
                icon: const Icon(Icons.clear_outlined),
                color: Colors.black87,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black87),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row BuildAddonOption(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.9,
          child: TextFormField(
            controller: addon_optionController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกตัวเลือกเพิ่มเติม';
              } else {}
            },
            maxLength: 255,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                color: Colors.black87,
                fontFamily: "MN MINI",
                fontSize: 19,
              ),
              hintStyle: TextStyle(
                fontFamily: "MN MINI",
                fontSize: 16,
              ),
              labelText: 'เพิ่มตัวเลือก',
              hintText: 'กรุณากรอกตัวเลือกเพิ่มเติม',
              contentPadding: EdgeInsets.only(left: 20),
              suffixIcon: IconButton(
                onPressed: () {
                  addon_optionController.clear();
                },
                icon: const Icon(Icons.clear_outlined),
                color: Colors.black87,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black87),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
