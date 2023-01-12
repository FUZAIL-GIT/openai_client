import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openai_client/model/ai_model_model.dart';
import 'package:openai_client/utils/data/data.dart' as data;
import 'package:openai_client/utils/style/app_theme.dart';
import 'package:openai_client/utils/toaster.dart';
import 'package:openai_client/view/components/gradient_text.dart';
import 'package:openai_client/view/screens/chat_screen.dart';

import '../../controller/api_key_controller.dart';
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
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    for (int index = modeController.currentMode.modeName
                                    .compareTo("Text Completions") ==
                                0
                            ? data.Data.GPTModelList.length - 1
                            : data.Data.CODExModelList.length - 1;
                        index >= 0;
                        index--)
                      textCompletions(
                        index,
                        modeController.currentMode.modeName
                                    .compareTo("Text Completions") ==
                                0
                            ? data.Data.GPTModelList[index]
                            : data.Data.CODExModelList[index],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget textCompletions(int index, AiModel aiModel) {
    APIKeyController apiKeyController = Get.put(APIKeyController());

    return GestureDetector(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        // color: Colors.grey.shade700,
        gradient: AppTheme.darkLinearGradient,
        boxShadow: AppTheme.neumorphismShadow,
        // gradient: AppTheme.linearGradient[2],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GradientText(
            aiModel.modelName.replaceAll(RegExp('text-'), '').toUpperCase(),
            gradient: const LinearGradient(colors: [
              // AppTheme.secondaryColor,
              // AppTheme.secondaryColor,
              Colors.white70,
              Colors.white70,
            ]),
            style: GoogleFonts.orbitron(
              textStyle: TextStyle(
                fontSize: 17.sp,
                color: Colors.cyan,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const Divider(
            color: Colors.amber,
            thickness: 1.2,
          ),
          Text(
            aiModel.modelDescription.toUpperCase(),
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
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: AppTheme.backgroundColor,
                  ),
                  onPressed: () {
                    if (apiKeyController
                        .textEditingController.text.isNotEmpty) {
                      Get.to(
                        () => ChatScreen(
                          aiModel: aiModel,
                        ),
                      );
                    } else {
                      Toaster().errorToast("First Enter Your Api Key");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  label: Text(
                    "CHAT",
                    style: GoogleFonts.orbitron(
                      textStyle: TextStyle(
                        fontSize: 12.sp,
                        color: AppTheme.backgroundColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
