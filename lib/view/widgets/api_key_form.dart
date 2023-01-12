import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openai_client/controller/api_key_controller.dart';
import 'package:openai_client/utils/style/app_theme.dart';
import 'package:openai_client/utils/toaster.dart';
import 'package:openai_client/utils/widget_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthKey extends StatelessWidget {
  const AuthKey({super.key});

  @override
  Widget build(BuildContext context) {
    APIKeyController apiKeyController = Get.put(APIKeyController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        width: double.infinity,
        // height: 150,
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Transform.rotate(
                      angle: pi / 4,
                      child: Icon(
                        Icons.key_rounded,
                        size: 25.sp,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "YOUR_API_KEY",
                      style: GoogleFonts.anaheim(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ],
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
                  child: Icon(
                    Icons.link,
                    size: 25.sp,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            widgetSpace(10),
            textFormField(apiKeyController),
          ],
        ),
      ),
    );
  }

  Widget textFormField(APIKeyController apiKeyController) {
    return Obx(() => GestureDetector(
          onTap: () async {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  enabled: apiKeyController.isEdit,
                  obscureText: true,
                  obscuringCharacter: '*',
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == '') {
                      return 'Please Enter YOUR_API_KEY';
                    }
                    return null;
                  },
                  controller: apiKeyController.textEditingController,
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
              ),
              tab(10),
              GestureDetector(
                  onTap: () {
                    if (apiKeyController.isEdit &&
                        apiKeyController.textEditingController.text
                                .compareTo('') !=
                            0) {
                      apiKeyController.toggle(false);
                    } else if (apiKeyController.isEdit &&
                        apiKeyController.textEditingController.text
                                .compareTo('') ==
                            0) {
                      Toaster().errorToast("Please Enter Your Api Key");
                    } else {
                      apiKeyController.toggle(true);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: apiKeyController.isEdit
                          ? AppTheme.secondaryColor
                          : AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: apiKeyController.isEdit
                        ? const Icon(Icons.done_rounded)
                        : const Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                          ),
                  )),
            ],
          ),
        ));
  }
}
