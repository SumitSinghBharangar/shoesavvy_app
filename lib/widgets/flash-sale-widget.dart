import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class FlashSaleWidget extends StatefulWidget {
  const FlashSaleWidget({super.key});

  @override
  State<FlashSaleWidget> createState() => _FlashSaleWidgetState();
}

class _FlashSaleWidgetState extends State<FlashSaleWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("categories").get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: Get.height * 0.2,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text("No Categories found"),
          );
        }
        if (snapshot.data != null) {
          return Container(
            height: Get.height * 0.20,
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  // CategoriesModel categoriesModel = CategoriesModel(
                  //   categoryId: snapshot.data!.docs[index]['categoryId'],
                  //   categoryImg: snapshot.data!.docs[index]['categoryImg'],
                  //   categoryName: snapshot.data!.docs[index]['categoryName'],
                  //   createdAt: snapshot.data!.docs[index]['createdAt'],
                  //   updatedAt: snapshot.data!.docs[index]['updatedAt'],
                  // );
                  return Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          // child: FillImageCard(
                          //   borderRadius: 11,
                          //   width: Get.width / 2.7,
                          //   heightImage: Get.height / 8,
                            // imageProvider: CachedNetworkImageProvider(
                            //   categoriesModel.categoryImg,
                            // ),
                            // title: Center(
                            //     child: Text(categoriesModel.categoryName)),
                          ),
                        ),
                      // )
                    ],
                  );
                })),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
