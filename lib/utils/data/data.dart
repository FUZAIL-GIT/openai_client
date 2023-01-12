// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openai_client/model/ai_model_model.dart';
import 'package:openai_client/model/mode_model.dart';

class Data {
  static List<Mode> modeList = [
    Mode(
      modeName: "Text Completions",
      modeDescription:
          "Next-Generation Text Completion: Unleash Your Writing Potential with OpenAI's AI Model",
      modeIcon: Icon(
        Icons.edit,
        size: 25.sp,
        color: Colors.grey.shade900,
      ),
      modeColor: Colors.teal,
    ),
    Mode(
      modeName: "Code Completions",
      modeDescription:
          "Revolutionize Your Coding Experience: OpenAI's AI Code Completion is at Your Service",
      modeIcon: Icon(
        Icons.code_outlined,
        size: 25.sp,
        color: Colors.grey.shade900,
      ),
      modeColor: Colors.purpleAccent,
    ),
    // Mode(
    //   modeName: "Image Generation",
    //   modeDescription:
    //       "Revolutionize Your Graphic Design: OpenAI's AI Image Generation is at Your Service",
    //   modeIcon: Icon(
    //     Icons.image_outlined,
    //     size: 25.sp,
    //     color: Colors.grey.shade900,
    //   ),
    //   modeColor: Colors.deepPurpleAccent,
    // ),
  ];
  static List<AiModel> GPTModelList = [
    AiModel(
      modelName: "text-curie-001",
      parentModelName: "GPT-3",
      modelDescription: "Very capable, but faster and lower cost than Davinci.",
      modelMaxTokens: 2048,
      modelTrainingDataDate: DateTime(2019, 10),
    ),
    AiModel(
      modelName: "text-babbage-001",
      parentModelName: "GPT-3",
      modelDescription:
          "Capable of straightforward tasks, very fast, and lower cost.",
      modelMaxTokens: 2048,
      modelTrainingDataDate: DateTime(2019, 10),
    ),
    AiModel(
      modelName: "text-ada-001",
      parentModelName: "GPT-3",
      modelDescription:
          "Capable of very simple tasks, usually the fastest model in the GPT-3 series, and lowest cost.",
      modelMaxTokens: 2048,
      modelTrainingDataDate: DateTime(2019, 10),
    ),
    AiModel(
      modelName: "text-davinci-003",
      parentModelName: "GPT-3",
      modelDescription:
          "Most capable GPT-3 model. Can do any task the other models can do, often with higher quality, longer output and better instruction-following. Also supports inserting completions within text.",
      modelMaxTokens: 4000,
      modelTrainingDataDate: DateTime(2021, 1),
    ),
  ];
  static List<AiModel> CODExModelList = [
    AiModel(
      modelName: "code-davinci-002",
      parentModelName: "Codex",
      modelDescription:
          "	Most capable Codex model. Particularly good at translating natural language to code. In addition to completing code, also supports inserting completions within code.",
      modelMaxTokens: 8000,
      modelTrainingDataDate: DateTime(2021, 1),
    ),
    AiModel(
      modelName: "code-cushman-001",
      parentModelName: "Codex",
      modelDescription:
          "Almost as capable as Davinci Codex, but slightly faster. This speed advantage may make it preferable for real-time applications.",
      modelMaxTokens: 2048,
      modelTrainingDataDate: DateTime(2021, 1),
    ),
  ];
}
