import 'package:barbar_shop/model/gallery_image.dart';
import 'package:barbar_shop/widgets/gallery_picker.dart';
import 'package:barbar_shop/widgets/image_grid_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class GalleryWidget extends StatefulWidget {
  final String uid;
  GalleryWidget({this.uid});
  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  final db = Firestore.instance;
  Widget makeImagesGrid(){
    String uid = widget.uid;
    String uids = widget.uid;
    return StreamBuilder<List<Gallery>>(

        stream: db
            .collection('users').document(widget.uid).collection("gallery")
            .snapshots()
            .map(firestoreToGalleryList),
        builder: (context, AsyncSnapshot<List<Gallery>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('error: ${snapshot.error.toString()}'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<Gallery> chatList = snapshot.data;
          return GridView.builder(
              itemCount: snapshot.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index){
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    height: 50,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            snapshot.data[index].imageUrl
                        ),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                );
              }
          );
        },
      );

  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: makeImagesGrid(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryPicker()),);
//
        },
      ),
    );
  }
}
