import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shoesavvy_app/controllers/google-signin-controller.dart';
import 'package:shoesavvy_app/screens/user-panel/trial-mainscreen.dart';

import 'package:shoesavvy_app/utils/app-constants.dart';
import 'package:shoesavvy_app/utils/routes/route-name.dart';
import 'package:shoesavvy_app/utils/routes/routes.dart';
import 'package:shoesavvy_app/utils/styles/appcolor.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GooglesignInController _googlesignInController =
      Get.put(GooglesignInController());
  @override
  Widget build(BuildContext context) {
    var sh = MediaQuery.of(context).size.height;
    var sw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppConstant.appMainColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              "assets/images/pngs/logo2.jpg",
              width: sw,
            ),
            const Text(
              "Happy Shopping",
              style: TextStyle(fontSize: 29),
            ),
            SizedBox(
              height: sh * 0.08,
            ),
            GestureDetector(
              onTap: () {
                _googlesignInController.signInWithGoogle();
              },
              child: Container(
                height: sh * 0.075,
                width: sw * 0.75,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/pngs/logogoogle.png",
                        height: 40,
                      ),
                      const Text(
                        "Sign in with Google",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: sh * 0.09,
            ),
            GestureDetector(
              child: Container(
                height: sh * 0.075,
                width: sw * 0.75,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.email,
                      ),
                      Text(
                        "Sign in with Email",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, RouteName.root);
              },
            ),
            SizedBox(
              height: sh * 0.095,
            ),
            GestureDetector(
              child: Container(
                height: sh * 0.07,
                width: sw * 0.75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), color: Colors.red),
                child: const Center(
                  child: Text(
                    "Skip Now  >> ",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const TrialMainScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
