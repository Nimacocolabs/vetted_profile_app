import 'dart:async';

import 'package:faculty_app/ui/admin/admin_home_screen.dart';
import 'package:faculty_app/ui/college/college_home_screen.dart';
import 'package:faculty_app/ui/committe/committe_home_screen.dart';
import 'package:faculty_app/ui/login_signUp_Screen/login_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/shared_prefs.dart';
import 'package:faculty_app/utils/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';



class SplashScreen extends StatefulWidget {
  final bool isFromLogout;

  const SplashScreen({Key? key, this.isFromLogout = false}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setScreenDimensions(context);

      setState(() {});

      if (UserDetails.apiToken.isEmpty) await SharedPrefs.init();
      await SharedPrefs.init();

      // Future.delayed(Duration(milliseconds: 1400), () {
      //   if (UserDetails.apiToken.isNotEmpty) {
      //     print("Token-->${UserDetails.apiToken}");
      //     print("role___________" + UserDetails.userRole);
      //     if (UserDetails.userRole == 'admin') {
      //       return Get.offAll(() => AdminHomeScreen());
      //     } else if (UserDetails.userRole == 'college') {
      //        return Get.offAll(() => CollegeHomeScreen());
      //     }
      //     else {
      //        return Get.offAll(() => CommitteHomeScreen());
      //     }
      //   } else {
      //      return Get.offAll(() => LoginScreen());
      //   }
      // });

    });
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
          children: [
            Expanded(
              child: Container(
                color: primaryColor, // Set the background color to blue
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height:MediaQuery.of(context).size.height *0.4,),
                      Image.asset(
                        "assets/images/logo2-full-white.png",
                        height: 150,
                      ),
                      // Text(
                      //   "Faculty Check",
                      //   style: TextStyle(
                      //     fontSize: 30,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.white,
                      //     fontFamily: 'Inter',
                      //   ),
                      // ),
                      // Text(
                      //   "credential system",
                      //   style: TextStyle(
                      //     fontSize: 30,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.white,
                      //     fontFamily: 'Inter',
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  'Powered by',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  "Cocoalabs India Pvt Ltd",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                ),
                SizedBox(height: 16),
                FutureBuilder<String>(
                  future: _getAppVersion(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    String version = '';
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData)
                      version = snapshot.data == null ? '' : 'Version : ${snapshot.data}';
                    return Text(
                      '$version',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
                    );
                  },
                ),
                SizedBox(height: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
