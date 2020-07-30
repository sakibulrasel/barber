import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id, role,name,businessName,imageUrl,startFrom;
  double lat, lan;
  int rating,distance;
  User(this.id, this.role,this.name,this.businessName,this.imageUrl,this.startFrom,this.lat,this.lan,this.rating,this.distance);

  User.fromFirestore(DocumentSnapshot doc)
      : id = doc.documentID,
        name = doc.data['name'],
        role = doc.data['role'],
        businessName = doc.data['businessName'],
        imageUrl = doc.data['imageUrl'],
        startFrom = doc.data['startFrom'],
        lat = doc.data['lat'],
        lan = doc.data['lan'],
        rating = doc.data['rating'];
}

List<User> firestoreToUserList(QuerySnapshot snapshot) {
  return snapshot.documents
      .map((doc) => User.fromFirestore(doc))
      .toList();
}