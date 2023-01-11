import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openai_client/utils/services/google_auth.dart';

class LoginController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController contentAnimationController;
  late AnimationController buttonAnimationController;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final RxDouble _opacity = 0.0.obs;
  final Rx<TextEditingController> _passWord = TextEditingController().obs;

  double get opacity => _opacity.value;
  TextEditingController get passWord => _passWord.value;
  late Animation contentAnimation;
  late Animation buttonAnimation;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<GoogleSignInAccount?> login() async {
    GoogleSignInAccount? googleSignInAccount = await GoogleAuth().login();

    return googleSignInAccount;
  }

  Future<void> logout() async {
    await GoogleAuth().logout();
  }

  @override
  void onInit() {
    super.onInit();
    //contentAnimation
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_opacity.value < 0.25) {
        _opacity.value = _opacity.value + 0.05;
      } else {
        timer.cancel();
      }
    });
    contentAnimationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    contentAnimation = Tween(begin: -0.4, end: 0.0).animate(
      CurvedAnimation(
          parent: contentAnimationController, curve: Curves.fastOutSlowIn),
    );
    contentAnimationController.forward();
    //buttonAnimation
    buttonAnimationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    buttonAnimation = Tween(begin: 0.4, end: 0.0).animate(
      CurvedAnimation(
          parent: buttonAnimationController, curve: Curves.fastOutSlowIn),
    );
    buttonAnimationController.forward();
  }
}
