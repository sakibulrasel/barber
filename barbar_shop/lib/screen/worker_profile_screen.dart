import 'dart:async';
import 'dart:io';

import 'package:barbar_shop/controller/profile_controller.dart';
import 'package:barbar_shop/screen/chatlist_page.dart';
import 'package:barbar_shop/widgets/about_widget.dart';
import 'package:barbar_shop/widgets/gallery.dart';
import 'package:barbar_shop/widgets/worker_about_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class WorkerProfileScreen extends StatefulWidget {
  final double lat, lan;
  WorkerProfileScreen({this.lat,this.lan});
  @override
  _WorkerProfileScreenState createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> with SingleTickerProviderStateMixin {

  TabController _tabController;
  bool isEditable = false;

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      isImageSelected = true;
      print('Image Path $_image');
    });
  }

  Future uploadPic(BuildContext context) async{
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
    setState(() {
      print("Profile Picture uploaded");
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });
  }
  String uid ="";
  bool isImageSelected = false;
  bool isUiLoaded = false;
  @override
  void initState() {
    _tabController = new TabController(length: 3,vsync:this );
    ProfileController.getUserId().then((value){
      setState(() {
        uid = value;
        isUiLoaded = true;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              /// Setting Header Banner
              Container(
                height: 160.0,
                color: Colors.blue,

              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 110),
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.5),
                      shape: BoxShape.circle,
                      image:
                      DecorationImage(
                          image: AssetImage("assets/images/profile.png")
                      )
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(top: 160, right: 30),
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: 30,
                    ),
                    onPressed: (){
                      setState(() {
                        isEditable = !isEditable;
                      });
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 220),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "John Doe",
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Text(
                        "Barberman at Redbox Barber",
                        style: TextStyle(
                            fontSize: 12
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "(125 Review)",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                height: 50,
                                width: 70,
                                color: Hexcolor("#e6f7ff"),
                                child: IconButton(
                                  icon: Icon(Icons.call),
                                  onPressed: (){},
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 70,
                                margin: EdgeInsets.only(right: 5,left: 5),
                                color: Hexcolor("#e6f7ff"),
                                child: IconButton(
                                  icon: Icon(Icons.chat),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatListPage()),);
                                  },
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 70,
                                margin: EdgeInsets.only(left: 5),
                                color: Hexcolor("#e6f7ff"),
                                child: IconButton(
                                  icon: Icon(Icons.rate_review),
                                  onPressed: (){},
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(left:20, top: 5),
                                  height: 50,
                                  width: 70,
                                  child: Text(
                                    "Call",
                                  )
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 5, top: 5),
                                  height: 50,
                                  width: 70,
                                  child: Text("Chat")
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 5, top: 5),
                                  height: 50,
                                  width: 70,
                                  child: Text("Review")
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 430),
                child: TabBar(
                  tabs: <Widget>[
                    Text(
                      "About",
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                    Text(
                      "Gallery",
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                    Text(
                      "Review",
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                  ],
                  controller: _tabController,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 480),
                height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(
                  children: <Widget>[
                    WorkerAboutWidget(isEditable: isEditable,lat: widget.lat, lan: widget.lan,),
                    isUiLoaded?
                    GalleryWidget(uid: uid,)
                        :CircularProgressIndicator(),
                    Text("Review"),
                  ],
                  controller: _tabController,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
