import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openai_client/view/screens/dashboard_screen.dart';
import 'package:openai_client/view/screens/login_screen.dart';

import 'utils/style/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(DevicePreview(
    enabled: false,
    builder: (_) => const MyApp(), // Wrap your app
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var email = GetStorage().read("email");

    var landingScreen =
        email != null ? const DashboardScreen() : const LoginScreen();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: AppTheme.backgroundColor),
    );
    return ScreenUtilInit(
        //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
        designSize: const Size(360, 690),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: landingScreen,
          );
        });
  }
}
