// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shoesavvy_app/controllers/get-user-data-controller.dart';
import 'package:shoesavvy_app/utils/utils.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<UserCredential?> signInMethod(
    String userEmail,
    String userPassword,
  ) async {
    try {
      EasyLoading.show(status: "Please Wait...");
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      EasyLoading.dismiss();
      return credential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      return Utils.toastMessage(e.toString());
    }
  }
}
