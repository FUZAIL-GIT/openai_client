import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  GetStorage storage = GetStorage();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<GoogleSignInAccount?> login() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    storage.write("email", googleSignInAccount!.email);
    storage.write("imageUrl", googleSignInAccount.photoUrl);
    storage.write("displayName", googleSignInAccount.displayName);
    return googleSignInAccount;
  }

  Future<void> logout() async {
    try {
      await googleSignIn.disconnect();
    } catch (e) {
      log("Error", error: e);
    }

    await storage.write("email", null);
    await storage.write("imageUrl", null);
    await storage.write("displayName", null);
  }
}
