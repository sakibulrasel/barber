import 'package:barbar_shop/controller/profile_controller.dart';
import 'package:barbar_shop/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiscoverController{
  static final db = Firestore.instance;
    static Future<List<User>> getWorkerList(double lat, double lan) async{
      QuerySnapshot  querySnapshot = await db
          .collection('users')
          .where("role",isEqualTo: "Barber")
          .where("isactivated",isEqualTo: true)
          .getDocuments();

      return querySnapshot.documents.map((doc)=>User(
          doc.documentID,
          doc.data['name'],
          doc.data['role'],
          doc.data['businessName'],
          doc.data['imageUrl'],
          doc.data['startFrom'],
          doc.data['lat'],
          doc.data['lan'],
          doc.data['rating'],
        ProfileController.calculateDistance(lat, lan, doc.data['lat'], doc.data['lan']),
      )).toList();

    }


}