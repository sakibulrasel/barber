import 'dart:async';

import 'package:barbar_shop/screen/google_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WorkerAboutWidget extends StatefulWidget {
  final bool isEditable;
  final double lat,lan;
  WorkerAboutWidget({this.isEditable,this.lat, this.lan});
  @override
  _WorkerAboutWidgetState createState() => _WorkerAboutWidgetState();
}

class _WorkerAboutWidgetState extends State<WorkerAboutWidget> {
  String businessName = "Redbox Barber";
  String startFrom = "\$\$";
  String address = "JL. Jamberaya No. 45, Sumberagung, Jember, Indonesia ";
  final Set<Marker> _markers = {};
  @override
  void initState() {
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_lastMapPosition.toString()),
      position: _lastMapPosition,
      infoWindow: InfoWindow(
        title: 'Really cool place',
        snippet: '5 Star Rating',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(23.8103, 90.4125);

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;


  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 15),
                      width: 150,

                      child: Text(
                        "Business Name",
                        style: TextStyle(
                            fontSize: 14
                        ),
                      )
                  ),
                  Container(
                      width: 150,
                      padding: EdgeInsets.only(left: 10),
                      child: widget.isEditable?TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontSize: 12
                            ),
                            hintText: "Business Name"
                        ),
                      ):Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          businessName,
                          style: TextStyle(
                              fontSize: 12
                          ),
                        ),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 15,top: widget.isEditable?0:10),
                      width: 150,

                      child: Text(
                        "Address",
                        style: TextStyle(
                            fontSize: 14
                        ),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 15),
                      width: 150,

                      child: widget.isEditable?Container(
                        margin: EdgeInsets.only(top: 15),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleMapScreen(lat: widget.lat,lan: widget.lan,)),);
                          },
                          child: Text("Adress"),
                        ),
                      ):Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          address,
                          style: TextStyle(
                              fontSize: 12
                          ),
                        ),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 15,top: widget.isEditable?0:10),
                      width: 150,

                      child: Row(
                        children: <Widget>[
                          Text(
                            "Get Direction",
                            style: TextStyle(
                                fontSize: 14
                            ),
                          ),
                          Icon(Icons.arrow_forward)
                        ],
                      )
                  ),

                  Container(
                      margin: EdgeInsets.only(left: 15,top: 20),
                      width: 150,

                      child: Row(
                        children: <Widget>[
                          Text(
                            "Opening Hours",
                            style: TextStyle(
                                fontSize: 14
                            ),
                          ),

                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 15,top: 10),
                      width: 150,

                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.stop,
                            size: 18,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              "Monday - Friday",
                              style: TextStyle(
                                  fontSize: 12
                              ),
                            ),
                          ),

                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 15,top: 10),
                      width: 150,

                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.stop,
                            size: 18,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              "Saturday",
                              style: TextStyle(
                                  fontSize: 12
                              ),
                            ),
                          ),

                        ],
                      )
                  ),

                ],
              ),
              Container(

                child: Column(
                  children: <Widget>[
                    Container(
                        width: 150,

                        child: Text(
                          "Start From",
                          style: TextStyle(
                              fontSize: 14
                          ),
                        )
                    ),
                    Container(
                        width: 150,

                        child: widget.isEditable?TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 12
                              ),
                              hintText: "Start From"
                          ),
                        ):Container(
                          margin: EdgeInsets.only(top: 15,bottom: 10),
                          child: Text(
                            startFrom,
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                        )
                    ),
                    Container(
                        width: 200,
                        height: 130,

                        padding: EdgeInsets.only(left: 30, top: 10),
                        child: Stack(
                          children: <Widget>[
                            GoogleMap(
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: _center,
                                zoom: 13.0,
                              ),
                              mapType: _currentMapType,
                              markers: _markers,
                              onCameraMove: _onCameraMove,
                            ),
                          ],
                        )
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 55),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "9.00 AM",
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                          Text(
                            "  -  ",
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                          Text(
                            "5.30 PM",
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "9.00 AM",
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                          Text(
                            "  -  ",
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                          Text(
                            "1.30 PM",
                            style: TextStyle(
                                fontSize: 12
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
