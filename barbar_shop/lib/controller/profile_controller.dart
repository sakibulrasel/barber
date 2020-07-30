import 'package:barbar_shop/model/gallery_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/services/base.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:google_maps_webservice/geocoding.dart';

class ProfileController{

  static String userId ="";
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final Firestore firestore = Firestore.instance;

  static List<Gallery> galleryList=[];
  static  double lat=23.8103;
  static  double lan=90.4125;
  static DocumentSnapshot docSnapshot;
  static Future<Position> getUserCurrentLocation() async{
    Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    double a = position.latitude;
    double ba = position.longitude;
    return position;


  }

  static Future<DocumentSnapshot> getUserData() async{
    var firebaseUser = await _firebaseAuth.currentUser();
    String uid = firebaseUser.uid;

    DocumentReference documentReference = firestore.collection("users").document(uid);
    await documentReference.get().then((datasnapshot){
      if(datasnapshot.exists){
        docSnapshot= datasnapshot;
      }
    });
    return docSnapshot;

  }

  static int calculateDistance(lat1, lon1, lat2, lon2){
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 - c((lat2 - lat1) * p)/2 +
          c(lat1 * p) * c(lat2 * p) *
              (1 - c((lon2 - lon1) * p))/2;

      double di = 12742 * asin(sqrt(a));
      double dis = 12742 * asin(sqrt(a));
      int as = di.toInt();
      return as;

  }

  static Future<String> getUserLocationAddress() async{
    try{
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('location: ${position.latitude}');
      final coordinates = new Coordinates(position.latitude, position.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      return first.featureName;

    }
    catch(e) {
      print("Error occured: $e");
    }
  }


  static Future<String> getUserId() async{
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    String uid = firebaseUser.uid;
    userId = uid;
    return uid;
  }

  static Future<List<Gallery>> getGallery(String uid) async{
    final Firestore firestore = Firestore.instance;
    firestore.collection("users").document(uid).collection("gallery");

}
}