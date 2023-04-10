import 'package:flutter/material.dart';
import 'package:fooddelivery/utility/my_constant.dart';
import 'package:fooddelivery/widgets/show_titles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowSignOut extends StatelessWidget {
  const ShowSignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear().then(
                  (value) => Navigator.pushNamedAndRemoveUntil(
                      context, MyConstant.routeAuthen, (route) => false),
                );
          },
          tileColor: MyConstant.primary,
          leading: Icon(
            Icons.exit_to_app_outlined,
            size: 36,
            color: Colors.white,
          ),
          title: ShowTitles(
            title: 'ออกจากระบบ',
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "MN MINI Bold",
            ),
          ),
          subtitle: ShowTitles(
            title: 'ออกจากระบบ เเละไปเข้าสู่ระบบ',
            textStyle: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontFamily: "MN MINI",
            ),
          ),
        ),
      ],
    );
  }
}