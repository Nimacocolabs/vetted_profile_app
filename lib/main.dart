import 'package:faculty_app/ui/splashScreen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // OneSignalNotifications.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp( MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FOCS",
      routes: {
        '/': (BuildContext context) => const SplashScreen(),
        // '/home': (BuildContext context) => HomeView(),
      },
      // initialRoute: AppPages.INITIAL,
      // getPages: AppPages.routes,
    );
  }
}
