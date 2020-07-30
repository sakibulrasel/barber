import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InboxController{
  static final Firestore firestore = Firestore.instance;
  static var firebaseUser;

  static Future getMessage() async{
    firebaseUser = await FirebaseAuth.instance.currentUser();
    QuerySnapshot qn = await firestore.collection("message").getDocuments();
    print(qn.documents);
    print(qn.documents);
    return qn.documents;
    }
}