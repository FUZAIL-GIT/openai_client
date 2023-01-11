import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openai_client/utils/data/data.dart';

import '../model/mode_model.dart';

class ModeController extends GetxController {
  final RxInt _currentIndex = 0.obs;
  final Rx<Mode> _currentMode = Mode(
    modeName: "Text Completions",
    modeDescription:
        "Next-Generation Text Completion: Unleash Your Writing Potential with OpenAI's AI Model",
    modeIcon: Icon(
      Icons.edit,
      size: 25.sp,
      color: Colors.grey.shade900,
    ),
    modeColor: Colors.teal,
  ).obs;
  int get currentIndex => _currentIndex.value;
  Mode get currentMode => _currentMode.value;

  void updateIndex(int value) {
    _currentIndex.value = value;
    _currentMode.value = Data.modeList[value];
    HapticFeedback.heavyImpact();
  }
}
