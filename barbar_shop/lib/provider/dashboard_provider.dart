import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class  DashboardProvider with ChangeNotifier{
  DashboardProvider.initialize(){
    notifyListeners();
  }

  static String role ="";
  final Firestore firestore = Firestore.instance;
  Future<void> checkRole() async{
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestore.collection("users").document(firebaseUser.uid).get().then((value){
     role = value.data["role"];

    });
  }

}