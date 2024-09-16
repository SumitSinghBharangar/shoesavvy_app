// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shoesavvy_app/controllers/get-device-token-controller.dart';
import 'package:shoesavvy_app/models/usermodel.dart';
import 'package:shoesavvy_app/utils/utils.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var ispasswordvisible = false.obs;
  Future<UserCredential?> signupmethod(
    String username,
    String userEmail,
    String userPhone,
    String userPassword,
  ) async {
    GetDeviceTokenController getDeviceTokenController =
        GetDeviceTokenController();
    try {
      EasyLoading.show(status: "Please Wait...");
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
// sends email verification to the user
      await userCredential.user!.sendEmailVerification();

      UserModel userModel = UserModel(
          uId: userCredential.user!.uid,
          username: username,
          email: userEmail,
          phone: userPhone,
          userImg: "",
          userDeviceToken: getDeviceTokenController.deviceToken.toString(),
          country: "",
          userAddress: "",
          street: "",
          isAdmin: false,
          isActive: true,
          createdOn: DateTime.now(),
          city: "");

      // add data to database
      _firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());
      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      return Utils.toastMessage(e.toString());
    }
  }
}
