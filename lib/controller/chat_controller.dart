// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:openai_client/model/ai_model_model.dart';

import '../api/api_config.dart';
import '../model/chat_model.dart';

class ChatController extends GetxController {
  final AiModel aiModel;
  ChatController({required this.aiModel});
  final ScrollController listScrollController = ScrollController();
  GlobalKey globalKey = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  final RxList<Message> _messageList = <Message>[].obs;
  List<Message> get messageList => _messageList.value;
  var client = http.Client();
  void scroll() {
    Future.delayed(const Duration(milliseconds: 333)).then((_) {
      listScrollController.animateTo(
          listScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 333),
          curve: Curves.easeOut);
    });
  }

  Future<void> sendMessage() async {
    Message message = Message(0, textEditingController.text);
    _messageList.value.add(message);
    _messageList.refresh();

    textEditingController.clear();
    Future.delayed(const Duration(milliseconds: 333)).then((_) {
      listScrollController.animateTo(
          listScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 333),
          curve: Curves.easeOut);
    });
    try {
      var body = jsonEncode({
        "model": aiModel.modelName,
        "prompt": message.text,
        "max_tokens": 200,
        "temperature": 0.9
      });
      log(body);
      var header = {
        HttpHeaders.authorizationHeader: 'Bearer ${ApiConfig.YOUR_API_KEY}',
        HttpHeaders.contentTypeHeader: 'application/json'
      };
      var url = Uri.parse(ApiConfig.baseApi + ApiConfig.completion);
      var response = await client.post(
        url,
        body: body,
        headers: header,
      );
      log(response.body);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var answer = data["choices"][0]["text"]
            .toString()
            .replaceAllMapped(RegExp(r'\n'), (match) => ' ');
        log(answer);
        _messageList.value.add(Message(1, answer));
        Future.delayed(const Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
        _messageList.refresh();
      }
    } catch (e) {
      log("Error", error: e);
    }
  }
}
