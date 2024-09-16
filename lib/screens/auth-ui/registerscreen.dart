import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoesavvy_app/controllers/get-device-token-controller.dart';

import 'package:shoesavvy_app/controllers/sign-up-controller.dart';

import '../../utils/styles/appcolor.dart';
import '../../utils/utils.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key, required this.controller});
  final PageController controller;
  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final SignUpController signUpController = SignUpController();
  final ValueNotifier<bool> _obsecurepassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obsecurepassword2 = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _repasswordcontroller = TextEditingController();
  FocusNode emailfocusnode = FocusNode();
  FocusNode passwordfocusnode = FocusNode();
  FocusNode usernamefocusnode = FocusNode();
  FocusNode phonenumberfocusnode = FocusNode();
  FocusNode repasswordfocusnode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _repasswordcontroller.dispose();
    emailfocusnode.dispose();
    passwordfocusnode.dispose();
    repasswordfocusnode.dispose();
    phonenumberfocusnode.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    usernamefocusnode.dispose();
    super.dispose();
  }

  final fKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.fromSize(
        size: MediaQuery.sizeOf(context),
        child: Stack(
          children: [
            Positioned(
              right: (MediaQuery.sizeOf(context).width / 2) - 150,
              top: 60,
              child: Transform.rotate(
                angle: -pi * 0.15,
                child: Image.asset(
                  "assets/images/pngs/6-c.png",
                  width: 300,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 300,
              child: Transform.rotate(
                angle: -pi * 0.1,
                child: Image.asset(
                  'assets/images/pngs/7-a.png',
                  width: 80,
                ),
              ),
            ),
            Positioned(
              right: 100,
              bottom: 30,
              child: Transform.rotate(
                angle: -pi * 0.04,
                child: Image.asset(
                  'assets/images/pngs/5-c.png',
                  width: 200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                clipBehavior: Clip.hardEdge,
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.fast),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.whiteColor.withOpacity(.8),
                      ),
                      child: Form(
                        key: fKey,
                        child: Column(
                          textDirection: TextDirection.ltr,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Sign up',
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
                              decoration: const InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                              ),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              focusNode: emailfocusnode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter your mail";
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                Utils.fieldfocuschange(
                                    context, emailfocusnode, usernamefocusnode);
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: "UserName",
                                prefixIcon: Icon(Icons.person_outline),
                                border: OutlineInputBorder(),
                              ),
                              controller: _usernameController,
                              keyboardType: TextInputType.emailAddress,
                              focusNode: usernamefocusnode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter your username";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                Utils.fieldfocuschange(context,
                                    usernamefocusnode, phonenumberfocusnode);
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Phone No",
                                prefixIcon: Icon(Icons.phone),
                                border: OutlineInputBorder(),
                              ),
                              controller: _phoneController,
                              keyboardType: TextInputType.number,
                              focusNode: phonenumberfocusnode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter your phone no";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                Utils.fieldfocuschange(context,
                                    phonenumberfocusnode, passwordfocusnode);
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                ValueListenableBuilder(
                                    valueListenable: _obsecurepassword,
                                    builder: (value, context1, child) {
                                      return TextFormField(
                                        obscureText: _obsecurepassword.value,
                                        controller: _passController,
                                        focusNode: passwordfocusnode,
                                        decoration: InputDecoration(
                                          hintText: "Password",
                                          prefixIcon:
                                              const Icon(Icons.lock_open),
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
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter your password";
                                          } else if (value.length < 6) {
                                            return "Password must have at least 6 chars";
                                          }
                                          return null;
                                        },
                                      );
                                    }),
                                const SizedBox(height: 10),
                                ValueListenableBuilder(
                                    valueListenable: _obsecurepassword2,
                                    builder: (context, child, value) {
                                      return TextFormField(
                                        obscureText: _obsecurepassword2.value,
                                        controller: _repasswordcontroller,
                                        focusNode: repasswordfocusnode,
                                        decoration: InputDecoration(
                                            hintText: "Comfirm Password",
                                            prefixIcon:
                                                const Icon(Icons.lock_open),
                                            suffixIcon: GestureDetector(
                                              child: Icon(
                                                  _obsecurepassword2.value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility),
                                              onTap: () {
                                                _obsecurepassword2.value =
                                                    !_obsecurepassword2.value;
                                              },
                                            ),
                                            border: const OutlineInputBorder()),
                                        validator: (value) {
                                          if (value != _passController.text) {
                                            return "Password did'nt matched";
                                          }
                                          return null;
                                        },
                                        // style: textFieldTextStyle(),
                                        // decoration: textFieldDecoration('Re-Password'),
                                      );
                                    }),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
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
                                  String name = _usernameController.text
                                      .trim()
                                      .toString();
                                  String email =
                                      _emailController.text.trim().toString();
                                  String password =
                                      _passController.text.trim().toString();
                                  String phone = _phoneController.text
                                      .trim()
                                      .toUpperCase();
                                  String userDeviceToken =
                                      GetDeviceTokenController()
                                          .deviceToken
                                          .toString();
                                  if (fKey.currentState!.validate()) {
                                    UserCredential? userCredential =
                                        await signUpController.signupmethod(
                                      name,
                                      email,
                                      phone,
                                      password,
                                    );
                                    if (userCredential != null) {
                                      Utils.flushbarerrormessage(
                                          "Please check your Mail to verify",
                                          context);
                                      FirebaseAuth.instance
                                          .signOut()
                                          .then((value) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        widget.controller.animateToPage(0,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.ease);
                                      }).onError((error, stackTrace) {
                                        Utils.flushbarerrormessage(
                                            error.toString(), context);
                                      });
                                    }
                                  }

                                  // FocusManager.instance.primaryFocus?.unfocus();
                                  // widget.controller.animateToPage(2,
                                  //     duration: const Duration(milliseconds: 500),
                                  //     curve: Curves.ease);
                                },
                                child: const Text("Create account"),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.primaryDark,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 2.5,
                                ),
                                InkWell(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    widget.controller.animateToPage(0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  },
                                  child: Text(
                                    'Log In ',
                                    style: TextStyle(
                                      color: AppColors.primaryHighContrast,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
