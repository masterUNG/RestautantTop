import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fooddelivery/utility/my_constant.dart';
import 'package:fooddelivery/widgets/show_signout.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
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
      
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BuildWalletCard(context, size),
                  BuildWidraw(size),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row BuildWalletCard(BuildContext context, double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 2),
          child: Center(
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.black,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 10, left: 15),
                child: SizedBox(
                  width: 350,
                  height: 131,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'ร้าน มีเเสงถนัดขาย',
                              style: TextStyle(
                                  fontFamily: 'MN MINI', fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
              if (formKey.currentState!.validate()) {
                Navigator.pushNamed(context, MyConstant.routeWidraw);
              }
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
