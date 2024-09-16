// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoesavvy_app/controllers/get-user-data-controller.dart';
import 'package:shoesavvy_app/screens/auth-ui/welcome-screen.dart';
import 'package:shoesavvy_app/utils/app-constants.dart';
import 'package:shoesavvy_app/utils/routes/route-name.dart';
import 'package:shoesavvy_app/utils/styles/appcolor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000)).then((value) {
      logged(context);
    });
    super.initState();
  }

  Future<void> logged(BuildContext context) async {
    if (user != null) {
      final GetUserDatacontroller getUserDatacontroller =
          GetUserDatacontroller();
      var userdata = await getUserDatacontroller.getUserData(user!.uid);
      if (userdata[0]["isAdmin"] == true) {
        Navigator.pushReplacementNamed(context, RouteName.adminscreen);
      } else {
        Navigator.pushReplacementNamed(context, RouteName.mainscreen);
      }
    } else {
      Navigator.pushReplacementNamed(context, RouteName.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    var sh = MediaQuery.of(context).size.height;
    var sw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppConstant.appMainColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: sh * 0.1,
              child: Image.asset(
                "assets/images/pngs/logo1.jpg",
                width: sw * 0.7,
              ),
            ),
            Positioned(
              top: sh * 0.6,
              child: Container(
                height: sh * 0.075,
                width: sw * 0.7,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Get Start",
                    style: TextStyle(
                        fontSize: 29,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Text(AppConstant.appPoweredby),
            )
          ],
        ),
      ),
    );
  }
}
