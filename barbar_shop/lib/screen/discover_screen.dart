import 'package:barbar_shop/controller/discover_controller.dart';
import 'package:barbar_shop/controller/profile_controller.dart';
import 'package:barbar_shop/model/gallery_image.dart';
import 'package:barbar_shop/model/user_model.dart';
import 'package:barbar_shop/screen/worker_filter_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
class DiscoverScreen extends StatefulWidget {
  final double lat, lan;
  final List<User> userList;
  DiscoverScreen({@required this.lat, @required this.lan, @required this.userList});
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {

  String searchAddr;
  String apiKey = "AIzaSyDoo9IaB7kQuAQ7HJQGsXa0zM7fVs01UNc";
  String address;


  @override
  void initState() {
       ProfileController.getUserLocationAddress().then((value){
         setState(() {
           print(value);
           address = value;
         });
       });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = Firestore.instance;
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 20,top: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Discover",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                        Container(

                            child: IconButton(
                              onPressed: (){
                                DiscoverController.getWorkerList(widget.lat,widget.lan).then((ulist){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkerFilterScreen(userList: ulist,)));
                                });

                              },
                              icon: Icon(Icons.filter_list),
                            )
                        )
                      ],
                    )
                ),
                Container(
                  margin: EdgeInsets.only(left: 20,top: 5),
                  child: Text(
                    "Find The Perfect Barberman",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                    padding: EdgeInsets.only(left: 10),
                    color: Colors.white,
                    child: TextField(
                      onTap: () async{
                        Prediction p = await PlacesAutocomplete.show(
                            context: context,
                            apiKey: apiKey,
                            language: "en",
                            components: [
                              Component(Component.country, "bd")
                            ]
                        );
                        if(p!=null){

                        }
                        print("tap");
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: (){

                            },
                          ),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.black.withOpacity(.8),
                              fontSize: 12
                          ),
                          hintText: address==null?"Search":address
                      ),
                      onChanged: (val){
                        setState(() {
                          searchAddr = val;
                        });
                      },
                    ),
                  ),
                ),

//
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.userList.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Color(0xff476cfb),
                                child: ClipOval(
                                  child: new SizedBox(
                                      width: 80.0,
                                      height: 80.0,
                                      child: Image.network(
                                        widget.userList[index].imageUrl,
                                        fit: BoxFit.fill,
                                      )

                                  ),
                                ),
                              ),

                              Expanded(
                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin:EdgeInsets.only(left: 25),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                              child: Text(widget.userList[index].name)
                                          ),
                                          Container(
                                              margin:EdgeInsets.only(top: 10),
                                              child: Text(
                                                "Berbarman at "+widget.userList[index].businessName,
                                                style: TextStyle(
                                                    fontSize: 10
                                                ),
                                              )
                                          )
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 75,
                                child: RaisedButton(
                                  onPressed: (){

                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: BorderSide(color: Colors.green)
                                  ),
                                  color: Colors.white,
                                  child: Text(
                                    "Open",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Ratings",
                                  style: TextStyle(
                                      fontSize: 12
                                  ),
                                ),
                                Text(
                                  "Start From",
                                  style: TextStyle(
                                      fontSize: 12
                                  ),
                                ),
                                Text(
                                  "Distance",
                                  style: TextStyle(
                                      fontSize: 12
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SmoothStarRating(
                                  rating: widget.userList[index].rating.toDouble(),
                                  size: 15,
                                  isReadOnly: true,
                                  filledIconData: Icons.star,
                                  halfFilledIconData: Icons.star_half,
                                  defaultIconData: Icons.star_border,
                                  starCount: 5,
                                  allowHalfRating: true,
                                  spacing: 2.0,
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 30),
                                  child: Text(
                                    widget.userList[index].startFrom+" \$",
                                    style: TextStyle(
                                        fontSize: 12
                                    ),
                                  ),
                                ),
                                Container(

                                  child: Text(
                                    widget.userList[index].distance.toString()+" M",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),

                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 120,
                            margin: EdgeInsets.only(top: 10),
                            child: StreamBuilder<List<Gallery>>(

                              stream: db
                                  .collection('users').document(widget.userList[index].id).collection("gallery")
                                  .snapshots()
                                  .map(firestoreToGalleryList),
                              builder: (context, AsyncSnapshot<List<Gallery>> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(child: Text('error: ${snapshot.error.toString()}'));
                                }
                                if (!snapshot.hasData) {
                                  return Center(child: CircularProgressIndicator());
                                }
                                List<Gallery> galleryList = snapshot.data;
                                return ListView.builder(
                                  itemCount: galleryList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                      return Container(
                                        height:50,
                                        child: Image.network(
                                          galleryList[index].imageUrl,
                                          fit: BoxFit.fill,
                                        ),
                                        padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                                        width: 120.0,

                                      );
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
