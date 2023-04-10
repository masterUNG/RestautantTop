import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/utility/my_constant.dart';
import 'package:fooddelivery/states/Navmenu/managemenu.dart';
import 'package:fooddelivery/states/Navmenu/history.dart';
import 'package:fooddelivery/states/Navmenu/wallet.dart';
import 'package:fooddelivery/widgets/show_signout.dart';
import 'package:fooddelivery/widgets/show_navbar.dart';
import 'package:fooddelivery/widgets/show_titles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalerService extends StatefulWidget {
  const SalerService({super.key});

  @override
  State<SalerService> createState() => _SalerServiceState();
}

class _SalerServiceState extends State<SalerService> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
     
     
      body: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text('หน้าหลัก', style: TextStyle(fontFamily: "MN MINI" ,fontSize: 16)),
        ),
      ),
    );
  }
}
