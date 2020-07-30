import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageGridItem extends StatefulWidget {
  int index;
  final String uid;
  ImageGridItem({this.index, this.uid});
  @override
  _ImageGridItemState createState() => _ImageGridItemState();
}

class _ImageGridItemState extends State<ImageGridItem> {

  @override
  Widget build(BuildContext context) {
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference photRef = storage.ref().child("gallery/"+widget.uid+"/");
    return Container();
  }
}
