import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openai_client/controller/login_controller.dart';
import 'package:openai_client/utils/style/app_theme.dart';
import 'package:openai_client/view/screens/dashboard_screen.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends GetView {
  static const String id = "/login_screen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.96),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 20.h),
              child: AnimatedBuilder(
                  animation: loginController.contentAnimation,
                  builder: (BuildContext context, Widget? child) {
                    return Transform(
                      transform: Matrix4.translationValues(0.0,
                          loginController.contentAnimation.value * height, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Image(
                          //   image: AssetImage("assets/images/Union.png"),
                          // ),
                          Text(
                            "Generate",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 47.38.sp,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(
                            height: 3.16.h,
                          ),
                          Text(
                            "Beautiful images through Simple Text.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.31.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 6.26.h,
                          ),
                          Text(
                            "AI Art Generator. Turn imagination into art. Our text-to-image AI empowers anyone to create attractive paintings, illustrations, and images. Describe what you want, and watch this app bring it to life.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              height: 1.2,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
          // const Image(
          //   height: double.infinity,
          //   width: double.infinity,
          //   fit: BoxFit.cover,
          //   image: AssetImage("assets/images/images.png"),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
                animation: loginController.buttonAnimation,
                builder: (BuildContext context, Widget? child) {
                  return Transform(
                    transform: Matrix4.translationValues(0.0,
                        loginController.buttonAnimation.value * height, 0.0),
                    child: MainButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: 42.h, vertical: 10.w),
                      label: "Login with google",
                      onPress: () async {
                        GoogleSignInAccount? googleSignInAccount =
                            await loginController.login();
                        if (googleSignInAccount != null) {
                          Get.to(
                            () => const DashboardScreen(),
                            transition: Transition.fade,
                            duration: const Duration(seconds: 2),
                            curve: Curves.linearToEaseOut,
                          );
                        }
                      },
                      backgroundColor: Colors.transparent,
                      borderColor: AppTheme.primaryColor,
                      labelStyle: TextStyle(
                          height: 1,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp),
                      leading: const Image(
                        image: AssetImage("assets/images/google_icon.png"),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
