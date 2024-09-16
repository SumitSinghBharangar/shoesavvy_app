import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoesavvy_app/controllers/get-device-token-controller.dart';

import 'package:shoesavvy_app/models/usermodel.dart';
import 'package:shoesavvy_app/screens/user-panel/main-screen.dart';
import 'package:shoesavvy_app/utils/utils.dart';

class GooglesignInController extends GetxController {
  final GoogleSignIn googlesignIn = GoogleSignIn();
  final FirebaseAuth _Auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async {
    final GetDeviceTokenController getDeviceTokenController =
        GetDeviceTokenController();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googlesignIn.signIn();
      if (googleSignInAccount != null) {
        EasyLoading.show(status: "Please Wait ...");
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _Auth.signInWithCredential(credential);

        final User? user = userCredential.user;
        if (user != null) {
          UserModel userModel = UserModel(
            uId: user.uid,
            username: user.displayName.toString(),
            email: user.email.toString(),
            phone: user.phoneNumber.toString(),
            userImg: user.photoURL.toString(),
            userDeviceToken: getDeviceTokenController.deviceToken.toString(),
            country: "",
            userAddress: "",
            street: "",
            isAdmin: false,
            isActive: true,
            createdOn: DateTime.now(),
            city: "",
          );
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .set(
                userModel.toMap(),
              )
              .then((value) {
            EasyLoading.dismiss();
            Get.offAll(
              () => const MainScreen(),
            );
            Utils.toastMessage("Sign In Successfully");
          }).onError(
            (error, stackTrace) {
              Utils.toastMessage(error.toString());
            },
          );
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      Utils.toastMessage(e.toString());
    }
  }
}
