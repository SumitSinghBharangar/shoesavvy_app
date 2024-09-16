import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shoesavvy_app/controllers/get-user-data-controller.dart';
import 'package:shoesavvy_app/controllers/sign-in-controller.dart';
import 'package:shoesavvy_app/screens/admin-panel/admin-panel-mainscreen.dart';
import 'package:shoesavvy_app/screens/user-panel/main-screen.dart';
import 'package:shoesavvy_app/utils/routes/route-name.dart';
import '../../utils/styles/appcolor.dart';
import '../../utils/utils.dart';
import '../../widgets/emil-input-box.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.controller});
  final PageController controller;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GetUserDatacontroller getUserDatacontroller = GetUserDatacontroller();
  final SignInController signInController = SignInController();
  final ValueNotifier<bool> _obsecurepassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  FocusNode emailfocusnode = FocusNode();
  FocusNode passwordfocusnode = FocusNode();
  @override
  void dispose() {
    emailfocusnode.dispose();
    passwordfocusnode.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.fromSize(
        size: MediaQuery.sizeOf(context),
        child: Stack(
          children: [
            Positioned(
              right: 40,
              top: 140,
              child: Transform.rotate(
                angle: pi * .1,
                child: Image.asset(
                  "assets/images/pngs/1-a.png",
                  width: 60,
                ),
              ),
            ),
            Positioned(
              left: 80,
              top: 300,
              child: Transform.rotate(
                angle: -pi * 0.05,
                child: Image.asset(
                  'assets/images/pngs/2-b.png',
                  width: 50,
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 20,
              child: Transform.rotate(
                angle: -pi * 0.14,
                child: Image.asset(
                  'assets/images/pngs/3-b.png',
                  width: 120,
                ),
              ),
            ),
            Positioned(
              // padding: const EdgeInsets.all(30),
              bottom: 30,
              left: 30,
              right: 30,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.whiteColor.withOpacity(.8),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    // padding: const EdgeInsets.symmetric(horizontal: 50),
                    children: [
                      Text(
                        'Log In',
                        style: TextStyle(
                          color: AppColors.primaryHighContrast,
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your Email.";
                            // } else if (!isEmail(value)) {
                            //   return "Invalid mail";
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        onFieldSubmitted: (value) {
                          Utils.fieldfocuschange(
                            context,
                            emailfocusnode,
                            passwordfocusnode,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _obsecurepassword,
                        builder: (value, context, child) {
                          return TextFormField(
                            obscureText: _obsecurepassword.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter you password";
                              } else if (value.length < 6) {
                                return "Must have at least 6 chars";
                              }
                              return null;
                            },
                            focusNode: passwordfocusnode,
                            controller: _passController,
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: const Icon(Icons.lock_open),
                              suffixIcon: GestureDetector(
                                child: Icon(_obsecurepassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onTap: () {
                                  _obsecurepassword.value =
                                      !_obsecurepassword.value;
                                },
                              ),
                              border: const OutlineInputBorder(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(
                                color: AppColors.primaryHighContrast,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EmailInputDialog();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.whiteColor,
                            ),
                            onPressed: () async {
                              String email =
                                  _emailController.text.trim().toString();
                              String password =
                                  _passController.text.trim().toString();
                              if (formKey.currentState!.validate()) {
                                UserCredential? userCredential =
                                    await signInController.signInMethod(
                                        email, password);

                                var userdata = await getUserDatacontroller
                                    .getUserData(userCredential!.user!.uid);

                                    
                                if (userCredential != null) {
                                  if (userCredential.user!.emailVerified) {
                                    if (userdata[0]["isAdmin"] == true) {
                                      Get.offAll(() => const AdminNameScreen());
                                      Get.snackbar("Success Admin Login",
                                          "Login Successfullu",
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          colorText: Colors.white);
                                    } else {
                                      Get.offAll(() => MainScreen());
                                      Get.snackbar("Success User Login",
                                          "Login Successfullu",
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          colorText: Colors.white);
                                    }
                                  } else {
                                    Utils.flushbarerrormessage(
                                        "Please verify your Email before Login",
                                        context);
                                  }
                                }
                              } else {
                                Utils.flushbarerrormessage(
                                    "Fill the credentials correctly..",
                                    context);
                              }
                            },
                            child: const Text("Sign In")),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account?',
                            style: TextStyle(
                              color: AppColors.primaryDark,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 2.5,
                          ),
                          InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              widget.controller.animateToPage(1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: AppColors.primaryHighContrast,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
