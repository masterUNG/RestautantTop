import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooddelivery/utility/my_constant.dart';
import 'package:fooddelivery/widgets/show_signout.dart';

class Widraw extends StatefulWidget {
  const Widraw({super.key});

  @override
  State<Widraw> createState() => _WidrawState();
}

class _WidrawState extends State<Widraw> {
  TextEditingController widraw_moneyController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? SelectedBank;
  List listBank = [
    "ธนาคารกรุงเทพ",
    "ธนาคารกสิกรไทย",
    "ธนาคารกรุงไทย",
    "ธนาคารทหารไทยธนชาต"
  ];
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
          'ถอนเงิน',
          style: TextStyle(
              color: Colors.black87, fontSize: 36, fontFamily: "MN MINI"),
        ),
        backgroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BuildBankSelect(size),
                  BuildWidrawMoney(size),
                  BuildWidraw(size),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row BuildWidrawMoney(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.9,
          child: TextFormField(
            controller: widraw_moneyController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกจำนวนเงินที่ต้องการถอน';
              } else {
                return null;
              }
            },
            maxLength: 255,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            keyboardType: TextInputType.number,
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
              labelText: 'จำนวนเงิน',
              hintText: 'กรุณากรอกจำนวนเงินที่ต้องการ',
              contentPadding: EdgeInsets.only(left: 20),
              suffixIcon: IconButton(
                onPressed: () {
                  widraw_moneyController.clear();
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
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row BuildBankSelect(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.9,
          child: DropdownButtonFormField<String>(
            value: SelectedBank,
            onChanged: (value) {
              setState(() {
                SelectedBank = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'กรุณาเลือกบัญชีธนาคาร';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                color: Colors.black,
                fontFamily: "MN MINI",
                fontSize: 19,
              ),
              hintStyle: TextStyle(
                fontFamily: "MN MINI",
                fontSize: 16,
              ),
              labelText: 'ธนาคาร',
              hintText: 'กรุณาเลือกธนาคาร',
              contentPadding: EdgeInsets.only(left: 20),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            items: listBank.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                    child: Text(value,
                        style: TextStyle(
                            height: 0.0, fontFamily: 'MN MINI', fontSize: 16))),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Row BuildWidraw(double size) {
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
              // if (formKey.currentState!.validate()) {
              //   Insertdata();
              // }
            },
            child: Text(
              'ถอนเงิน',
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
