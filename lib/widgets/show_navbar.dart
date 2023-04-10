import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/utility/my_constant.dart';
import 'package:fooddelivery/states/Navmenu/managemenu.dart';
import 'package:fooddelivery/states/Navmenu/history.dart';
import 'package:fooddelivery/states/Navmenu/wallet.dart';
import 'package:fooddelivery/widgets/show_signout.dart';
import 'package:fooddelivery/widgets/show_titles.dart';
import 'package:fooddelivery/widgets/widget_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fooddelivery/states/saler_service.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _index = 0;
  final screens = [
    SalerService(),
    ManageMenu(),
    History(),
    Wallet(),
  ];

  var titles = <String>[
    'หน้าหลัก',
    'จัดการเมนู',
    'ประวัติ',
    'กระเป๋าเงิน',
  ];

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShowTitles(
          title: titles[_index],
          textStyle: MyConstant().h2Style(),
        ),
        actions: [
          WidgetIconButton(
            iconData: Icons.exit_to_app,
            tapFunc: () async {
               SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear().then(
                  (value) => Navigator.pushNamedAndRemoveUntil(
                      context, MyConstant.routeAuthen, (route) => false),
                );
            },
          )
        ],
      ),
      body: screens[_index],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: onTabTapped,
          selectedItemColor: Color(0xffFF8126),
          unselectedItemColor: Colors.black87,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'หน้าหลัก',
              backgroundColor: Color(0xffFFC077),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu),
              label: 'จัดการเมนู',
              backgroundColor: Color(0xffFFC077),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined),
              label: 'ประวัติ',
              backgroundColor: Color(0xffFFC077),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: 'กระเป๋าเงิน',
              backgroundColor: Color(0xffFFC077),
            ),
          ],
        ),
      ),
    );
  }
}
