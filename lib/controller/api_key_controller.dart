import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openai_client/utils/toaster.dart';
import 'package:openai_client/utils/widget_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/style/app_theme.dart';

class APIKeyController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  final RxBool _isEdit = false.obs;
  bool get isEdit => _isEdit.value;
  toggle(bool value) {
    _isEdit.value = value;
    if (!value) {
      GetStorage().write('YOUR_API_KEY', textEditingController.text);
    }
  }

  Future inputPrompt() {
    return Get.defaultDialog(
      title: "Please Enter Your API_KEY",
      content: Column(
        children: [
          Wrap(
            children: [
              Text(
                "Visit : ",
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
              ),
              GestureDetector(
                onTap: () async {
                  var url =
                      Uri.parse('https://beta.openai.com/account/api-keys');

                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Text(
                  "https://beta.openai.com/account/api-keys",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ],
          ),
          widgetSpace(10),
          TextFormField(
            obscureText: true,
            obscuringCharacter: '*',
            style: const TextStyle(color: Colors.white),
            validator: (value) {
              if (value == '') {
                return 'Please Enter YOUR_API_KEY';
              }
              return null;
            },
            controller: textEditingController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 14.w),
              filled: true,
              fillColor: AppTheme.surfaceColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                  color: AppTheme.primaryColor,
                  width: 1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                  color: AppTheme.primaryColor,
                  width: 1,
                ),
              ),
              focusColor: AppTheme.primaryColor,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.amber,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            cursorColor: const Color(0xff65D1BA),
          ),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 20.w,
      ),
      backgroundColor: Colors.grey.shade900,
      confirm: ElevatedButton.icon(
        icon: const Icon(
          Icons.done,
          color: AppTheme.backgroundColor,
        ),
        onPressed: () {
          if (textEditingController.text.isNotEmpty) {
            GetStorage()
                .write('YOUR_API_KEY', textEditingController.text)
                .then((value) => Get.back());
          } else {
            Toaster().errorToast("Please Enter Your API_KEY");
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
        label: Text(
          "SAVE",
          style: GoogleFonts.orbitron(
            textStyle: TextStyle(
              fontSize: 12.sp,
              color: AppTheme.backgroundColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      titleStyle: TextStyle(color: Colors.white, fontSize: 18.sp),
      radius: 10.r,
    );
  }

  @override
  Future<void> onInit() async {
    textEditingController.text = GetStorage().read('YOUR_API_KEY') ?? '';

    Future.delayed(const Duration(milliseconds: 500), () {
      if (textEditingController.text.compareTo('') == 0) {
        inputPrompt();
      }
    });

    super.onInit();
  }
}
