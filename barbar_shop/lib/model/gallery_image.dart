import 'package:cloud_firestore/cloud_firestore.dart';

class Gallery {
  String imageUrl;
  Gallery(this.imageUrl);

  Gallery.fromFirestore(DocumentSnapshot doc)
      :
        imageUrl = doc.data['imageUrl'];
}

List<Gallery> firestoreToGalleryList(QuerySnapshot snapshot) {
  return snapshot.documents
      .map((doc) => Gallery.fromFirestore(doc))
      .toList();
}