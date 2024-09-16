import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetUserDatacontroller extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Object?>>> getUserData(String uId)async{
    final QuerySnapshot userdata =await _firestore.collection("users").where("uId",isEqualTo: uId).get();
    return userdata.docs;
  }
}