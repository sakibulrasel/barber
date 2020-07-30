
import 'dart:convert';
import 'dart:core';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class AuthProvider with ChangeNotifier{

  AuthProvider.initialize(){
//  readPrefs();
    notifyListeners();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;
  String uid;

  Future<bool> loginWithEmail({
    @required String email,
    @required String password
  }) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      return false;
      }
  }

  Future<void> updateProfile(
      String userName,
      String business,
      String startFrom,
      String address,
      String startTime,
      String endTime,
      String offdayStartTime,
      String offdayEndtime)async{
    var firebaseUser = await _firebaseAuth.currentUser();
    uid = firebaseUser.uid.toString();
     await firestore.collection("users").document(uid)
    .updateData({
      "userName":userName,
      "businessName":business,
       "startFrom":startFrom,
       "address":address,
       "startTime":startTime,
       "endTime":endTime,
       "offdayStartTime":offdayStartTime,
       "offdayEndTime":offdayEndtime,
       "isactivated":true
     });
  }


  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String role,
  }) async {
    try {
      double lat, lan;
      final Geolocator geolocator = await Geolocator()..forceAndroidLocationManager;
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
          lat = position.latitude;
          lan = position.longitude;

      }).catchError((e) {
        print(e);
      });
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      firestore.collection("users").document(firebaseUser.uid).setData(
          {
            "email" : email,
            "password":password,
            "role":role,
            "uid":firebaseUser.uid,
            "lat":lat,
            "lan":lan,
            "isactivated":false
          }).then((_){
        print("success!");
      });


      return true;
    } catch (e) {
      print(e);
      print(e.message);
      return false;
    }
  }



  Future<AuthResult> login(String email, String password) async{
    FirebaseAuth _auth = FirebaseAuth.instance;
   try{
     AuthResult user = (await _auth.signInWithEmailAndPassword(email: email, password: password)) as AuthResult;
     if(user!=null){
       return user;
     }
   }catch(e){
     return null;
   }
  }




  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }



}