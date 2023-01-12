// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:openai_client/model/ai_model_model.dart';
import 'package:openai_client/utils/services/logging_service.dart';

import '../api/api_config.dart';
import '../model/chat_model.dart';

class ChatController extends GetxController {
  final AiModel aiModel;
  ChatController({required this.aiModel});
  final ScrollController listScrollController = ScrollController();
  final RxBool _isTyping = false.obs;
  final RxDouble _temperature = 0.4.obs;
  double get temperature => _temperature.value;
  final RxDouble _maxTokens = 200.0.obs;
  double get maxTokens => _maxTokens.value;
  GlobalKey globalKey = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  final RxList<Message> _messageList = <Message>[].obs;
  List<Message> get messageList => _messageList.value;
  bool get isTyping => _isTyping.value;
  var client = http.Client();

  //scroll to down
  void scroll() {
    _isTyping.value = false;
    Future.delayed(const Duration(milliseconds: 333)).then((_) {
      listScrollController.animateTo(
          listScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 333),
          curve: Curves.easeOut);
    });
  }

  void onChangeTemperature(double value) {
    _temperature.value = value;
  }

  void onChangeMaxToken(double value) {
    _maxTokens.value = value;
  }

//send data to ai model
  Future<void> sendMessage() async {
    Message message = Message(0, textEditingController.text);
    _messageList.value.add(message);
    _messageList.refresh();
    _isTyping.value = true;
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
        "max_tokens": int.parse(_maxTokens.value.toStringAsFixed(0)),
        "temperature": _temperature.value
      });
      talker.log(body);
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
      talker.good(response.body);
      talker.good(response.statusCode.toString());
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
      talker.error(e);
    }
  }
}
