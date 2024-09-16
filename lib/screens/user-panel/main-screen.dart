// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoesavvy_app/widgets/banner-widget.dart';
import 'package:shoesavvy_app/widgets/categoris-widget.dart';

import 'package:shoesavvy_app/widgets/custom-drawer-widget.dart';
import 'package:shoesavvy_app/widgets/heading-widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Screen"),
      ),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 90,
                ),
                const Text("shoesavvy"),
                // banners
                const BannerWidget(),
                const Text("dfkdkfdjkl"),
                HeadingWidget(
                  buttontext: "See More",
                  headingtitle: "Categories",
                  ontap: () {},
                  subheadingtitle: "Low budget",
                ),
                CategoriesWidget(),
                HeadingWidget(
                  buttontext: "See More",
                  headingtitle: "Flash Sale",
                  ontap: () {},
                  subheadingtitle: "According to Your Budget",
                ),
                CategoriesWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
