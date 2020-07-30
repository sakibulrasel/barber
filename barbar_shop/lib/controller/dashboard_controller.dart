import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashboardController{
  static final Firestore firestore = Firestore.instance;
  static String role ="";
  static Future<String> checkRole() async{
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    await firestore.collection("users").document(firebaseUser.uid).get().then((value){
      print(value.data["role"]);
      role = value.data["role"];
      return value.data["role"];
    });
  }

  static LatLng getUserLocation(double lat, double lan) {
    LatLng _center = LatLng(lat,lan);
    return _center;
  }
}