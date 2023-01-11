import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openai_client/controller/chat_controller.dart';
import 'package:openai_client/model/ai_model_model.dart';
import 'package:openai_client/utils/style/app_theme.dart';
import 'package:openai_client/utils/widget_helper.dart';

class ChatScreen extends StatelessWidget {
  final AiModel aiModel;
  const ChatScreen({super.key, required this.aiModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
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
          textFormField(chatController),
          widgetSpace(15),
        ],
      ),
    );
  }

  Widget textFormField(
    ChatController chatController,
  ) {
    return GestureDetector(
      // onTap: () {
      //   log("message");
      //   if (!bluetoothController.isConnected) {
      //     Toaster().logToast("Sorry the deivce is no longer connected");
      //   }
      // },
      child: TextFormField(
        // style: AppTheme.miniTextStyle1(fontSize: 15),
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
          // suffixIcon: GestureDetector(
          //     onTap: () {
          //       terminalController.sendData();
          //     },
          //     child: const GradientIcon(
          //         Icons.send, 25, AppTheme.accentLinearGradient)),
          // fillColor: Colors.yellow,
          hintText: "Please Enter Data",
          // hintStyle: AppTheme.miniTextStyle1(),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(
              color: AppTheme.primaryColor,
              width: 2,
            ),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(
              color: AppTheme.primaryColor,
              width: 2,
            ),
          ),
          focusColor: AppTheme.primaryColor,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppTheme.primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          prefixIcon: const Icon(
            Icons.terminal,
            color: AppTheme.primaryColor,
          ),
        ),
        cursorColor: const Color(0xff65D1BA),
      ),
    );
  }
}
