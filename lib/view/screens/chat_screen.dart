import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openai_client/controller/chat_controller.dart';
import 'package:openai_client/model/ai_model_model.dart';
import 'package:openai_client/model/chat_model.dart';
import 'package:openai_client/utils/style/app_theme.dart';
import 'package:openai_client/utils/widget_helper.dart';

class ChatScreen extends StatelessWidget {
  final AiModel aiModel;
  const ChatScreen({super.key, required this.aiModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController(aiModel: aiModel));
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        title: Text(
          aiModel.modelName.toUpperCase(),
          // style: AppTheme.bodyTextStyle(),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          messageList(chatController),
          textFormField(chatController),
        ],
      ),
    );
  }

  Widget textFormField(
    ChatController chatController,
  ) {
    return GestureDetector(
      onTap: () async {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          style: const TextStyle(color: Colors.white),
          validator: (value) {
            if (value == '') {
              return 'Please Enter label';
            }
            return null;
          },
          controller: chatController.textEditingController,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.surfaceColor,
            suffixIcon: GestureDetector(
                onTap: () async {
                  await chatController.sendMessage();
                },
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                )),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(
                color: AppTheme.primaryColor,
                width: 1,
              ),
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(
                color: AppTheme.primaryColor,
                width: 1,
              ),
            ),
            focusColor: AppTheme.primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppTheme.primaryColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            // prefixIcon: const Icon(
            //   Icons.terminal,
            //   color: AppTheme.primaryColor,
            // ),
          ),
          cursorColor: const Color(0xff65D1BA),
        ),
      ),
    );
  }

  Widget messageList(ChatController chatController) {
    return Obx(() => Expanded(
          child: ListView.builder(
              controller: chatController.listScrollController,
              shrinkWrap: true,
              itemCount: chatController.messageList.length,
              itemBuilder: (context, index) {
                return chatBox(
                    chatController.messageList[index], chatController);
              }),
        ));
  }

  Widget chatBox(Message message, ChatController chatController) {
    return Padding(
      padding: EdgeInsets.only(
          top: 10.h,
          bottom: 10.h,
          right: message.whom == 1 ? 100.w : 10.w,
          left: message.whom == 0 ? 100.w : 10.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: message.whom == 0
              ? Colors.white.withOpacity(0.3)
              : AppTheme.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: message.whom == 1
                ? const Radius.circular(20)
                : const Radius.circular(0),
            bottomRight: message.whom == 0
                ? const Radius.circular(20)
                : const Radius.circular(0),
          ),
        ),
        child: message.whom == 1
            ? SizedBox(
                // width: 250.0,
                child: DefaultTextStyle(
                  style: GoogleFonts.varela(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  child: AnimatedTextKit(
                    onFinished: () {
                      chatController.scroll();
                    },
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(message.text, cursor: '|'),
                    ],
                    onTap: () {
                      log("Tap Event");
                    },
                  ),
                ),
              )
            : SelectableText(
                message.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
      ),
    );
  }
}
