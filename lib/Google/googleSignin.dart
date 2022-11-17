import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninApi {
  static const clientID =
      "903655522696-eh0jslbq9gc9n57g76rv9j2e4msafbp8.apps.googleusercontent.com";
  static final googleSignin = GoogleSignIn(clientId: clientID);
  Future<GoogleSignInAccount?> login() async {
    try {
      final user = await googleSignin.signIn();
      return user;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future logout() => googleSignin.disconnect();
}
