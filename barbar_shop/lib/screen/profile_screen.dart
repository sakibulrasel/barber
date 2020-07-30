import 'dart:async';
import 'dart:io';

import 'package:barbar_shop/controller/profile_controller.dart';
import 'package:barbar_shop/screen/chatlist_page.dart';
import 'package:barbar_shop/screen/dashboard_screen.dart';
import 'package:barbar_shop/utils/global_state.dart';
import 'package:barbar_shop/widgets/about_widget.dart';
import 'package:barbar_shop/widgets/gallery.dart';
import 'package:barbar_shop/widgets/review_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
class ProfileScreen extends StatefulWidget {
  final double lat, lan;
  final String role;
  ProfileScreen({this.lat,this.lan,this.role});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isEditable = false;

  File _image;
  String businessName;
  String userName;
  String totalReview;
  String profileImageUrl;
  TextEditingController userNameController;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }

  Future uploadPic(BuildContext context) async{
    FirebaseStorage _storage = FirebaseStorage.instance;
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    String userId = firebaseUser.uid;
    String fileName = basename(_image.path);
    var timeKey = new DateTime.now();
    StorageReference reference = _storage.ref().child("profile/"+userId);

    StorageUploadTask uploadTask = reference.child(timeKey.toString()+".jpg").putFile(_image);
    var imageUrl = await(await uploadTask.onComplete).ref.getDownloadURL();
    String url = imageUrl.toString();
    final Firestore firestore = Firestore.instance;
    setState(() {
      profileImageUrl = url;
    });

    firestore.collection("users").document(firebaseUser.uid).updateData(
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

  userTextValue() {
    print("title text field: ${userNameController.text}");
    return userNameController.text;
  }


  String uid ="";
  bool isImageSelected = false;
  bool isUiLoaded = false;
  @override
  void initState() {
    ProfileController.getUserData().then((value){
      if(value!=null){

        setState(() {
          if(value.data["businessName"]!=null){
            businessName = value.data["businessName"].toString();
          }
          if(value.data["userName"]!=null){
            userName = value.data["userName"].toString();
          }

          if(value.data["totalReview"]!=null){
            totalReview = value.data["totalReview"].toString();
          }

          if(value.data["imageUrl"]!=null){
            profileImageUrl = value.data["imageUrl"].toString();
          }

        });
      }
    });
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
    store.set("userName", userTextValue);
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
                  child: GestureDetector(
                    onTap: (){
                      getImage().then((_){
                        uploadPic(context).then((_){
                         setState(() {
                           isImageSelected = true;
                           Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(i: 0,)),);
                         });
                        });
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 110),
                      height: 100.0,
                      width: 100.0,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Color(0xff476cfb),
                        child: ClipOval(
                          child: new SizedBox(
                            width: 180.0,
                            height: 180.0,
                            child: profileImageUrl!=null?Image.network(
                              profileImageUrl,
                              fit: BoxFit.fill,
                            ):Image(
                              image: AssetImage("assets/images/profile.png"),
                            )

                          ),
                        ),
                      ),
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
               Align(
                 alignment: Alignment.center,
                 child: Container(
                      margin: EdgeInsets.only(top: 220),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 20.0,right: 20),

                            child: isEditable?Container(
                              child: TextField(
                                keyboardType: TextInputType.text,

                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 12
                                    ),
                                    hintText: "Enter Your Name"
                                ),
                                style: TextStyle(
                                    fontSize: 12
                                ),
                                controller: userName==null?userNameController=TextEditingController():userNameController=TextEditingController(
                                    text: userName
                                ),

                              ),
                            ):Text(
                              userName==null?"Please update your name":userName,
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Text(
                              businessName==null?"Please Upadte your Business Name":"Barberman at "+businessName,
                              style: TextStyle(
                                  fontSize: 12
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              totalReview==null?"(0 Review)":"(" +totalReview+" Reviews)",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
               ),

                Container(
                  margin: EdgeInsets.only(top: 330),
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
                  margin: EdgeInsets.only(top: 380),
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    children: <Widget>[
                      AboutWidget(isEditable: isEditable,lat: widget.lat, lan: widget.lan,role: widget.role,username: isEditable?userNameController.text:userName,),
                      isUiLoaded?
                      GalleryWidget(uid: uid,)
                          :CircularProgressIndicator(),
                      ReviewWidget(),
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




