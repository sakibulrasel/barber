import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class GalleryPicker extends StatefulWidget {
  @override
  _GalleryPickerState createState() => _GalleryPickerState();
}

class _GalleryPickerState extends State<GalleryPicker> {
  File _image;
  bool isImageSelected = false;


  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        isImageSelected = true;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async{
      FirebaseStorage _storage = FirebaseStorage.instance;
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      String userId = firebaseUser.uid;
      String fileName = basename(_image.path);
      var timeKey = new DateTime.now();
      StorageReference reference = _storage.ref().child("gallery/"+userId);

      StorageUploadTask uploadTask = reference.child(timeKey.toString()+".jpg").putFile(_image);
      var imageUrl = await(await uploadTask.onComplete).ref.getDownloadURL();
      String url = imageUrl.toString();
      final Firestore firestore = Firestore.instance;

      firestore.collection("users").document(firebaseUser.uid).collection("gallery").document().setData(
          {
            "imageUrl" : url,
          }).then((_){
        print("success!");
      });
      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
      setState(() {
        print("Profile Picture uploaded");
        Navigator.of(context).pop();
      });
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Color(0xff476cfb),
                  child: ClipOval(
                    child: new SizedBox(
                      width: 180.0,
                      height: 180.0,
                      child: isImageSelected?Image.file(
                        _image,
                        fit: BoxFit.fill,
                      ):
                      Image.network(
                        "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: isImageSelected? IconButton(
                  icon: Icon(Icons.save),
                  iconSize: 100,
                  onPressed: (){
                    uploadPic(context);
                  },
                ): IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 100,
                  onPressed: (){
                    setState(() {
                      getImage();

                    });
                  },
                ),
              ),
              Container(
                child: Text(
                    "Pick Your image"
                ),
              )
            ],
          )
      ),
    );
  }
}
