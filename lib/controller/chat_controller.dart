// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../model/chat_model.dart';

class ChatController extends GetxController {
  final ScrollController listScrollController = ScrollController();
  GlobalKey globalKey = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  final RxList<Message> _messages = <Message>[].obs;
  List<Message> get messages => _messages.value;
}
