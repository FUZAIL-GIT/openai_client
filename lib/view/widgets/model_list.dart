import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openai_client/utils/data/data.dart';
import 'package:openai_client/utils/style/app_theme.dart';
import 'package:openai_client/utils/widget_helper.dart';
import 'package:openai_client/view/screens/chat_screen.dart';

import '../../controller/mode_controller.dart';

class ModelList extends StatelessWidget {
  const ModelList({super.key});

  @override
  Widget build(BuildContext context) {
    ModeController modeController = Get.put(ModeController());

    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Text(
                modeController.currentMode.modeName
                            .compareTo("Text Completions") ==
                        0
                    ? "GPT-3 MODELS : "
                    : "CODEX MODELS",
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.anekDevanagari(
                  textStyle: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.grey.shade100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: [
                    if (modeController.currentMode.modeName
                            .compareTo("Text Completions") ==
                        0)
                      for (int index = Data.GPTModelList.length - 1;
                          index >= 0;
                          index--)
                        textCompletions(index),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget textCompletions(int index) {
    return GestureDetector(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.white.withOpacity(0.15),

        // gradient: AppTheme.linearGradient[2],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Data.GPTModelList[index].modelName.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.cabin(
              textStyle: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          widgetSpace(6),
          Text(
            Data.GPTModelList[index].modelDescription.toUpperCase(),
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.anekDevanagari(
              textStyle: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey.shade100,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          // Text(
          //   DateFormat('MMM,y').format(
          //       Data.GPTModelList[i].modelTrainingDataDate),
          //   style: GoogleFonts.anekDevanagari(
          //     textStyle: TextStyle(
          //       fontSize: 13.sp,
          //       color: Colors.white,
          //       fontWeight: FontWeight.normal,
          //     ),
          //   ),
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: ElevatedButton(
          //         onPressed: () {},
          //         child: const Text("Read more"),
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: Colors.transparent,
          //           side: const BorderSide(
          //             width: 1,
          //             color: AppTheme.primaryColor,
          //           ),
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10.r)),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () => ChatScreen(
                        aiModel: Data.GPTModelList[index],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.backgroundColor,
                    // side: const BorderSide(
                    //   width: 1,
                    //   color: AppTheme.primaryColor,
                    // ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  child: const Text("Try it >"),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
