// ignore_for_file: file_names

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import 'package:shoesavvy_app/utils/utils.dart';

class GetDeviceTokenController extends GetxController {
  String? deviceToken;

  @override
  void onInit() {
    super.onInit();
    getDeviceToken();
  }

  Future<void> getDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        deviceToken = token;
        update();
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }
}
