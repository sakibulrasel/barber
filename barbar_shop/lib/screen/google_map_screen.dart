import 'dart:async';

import 'package:barbar_shop/controller/dashboard_controller.dart';
import 'package:barbar_shop/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
class GoogleMapScreen extends StatefulWidget {
  final double lat, lan;
  GoogleMapScreen({this.lat, this.lan});
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  String searchAddr;
  String apiKey = "AIzaSyDoo9IaB7kQuAQ7HJQGsXa0zM7fVs01UNc";
  static Position _currentPosition;
  static double lati=0, long=0;


  LatLng _lastMapPosition;
  final Set<Marker> _markers = {};

  MapType _currentMapType = MapType.normal;


  void _onCameraMove(CameraPosition position) {
    if(_lastMapPosition==null){
      _lastMapPosition = DashboardController.getUserLocation(lati, long);
    }
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }


  @override
  void initState() {

        _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_lastMapPosition==null?DashboardController.getUserLocation(lati, long).toString():_lastMapPosition.toString()),
      position: _lastMapPosition==null?DashboardController.getUserLocation(lati, long):_lastMapPosition,
      infoWindow: InfoWindow(
        title: 'Really cool place',
        snippet: '5 Star Rating',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  lati,
                  long
              ),
              zoom: 13.0,
            ),
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),

          GestureDetector(

            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.only(left: 20),
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
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: (){

                      },
                    ),
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        color: Colors.black.withOpacity(.8),
                        fontSize: 14
                    ),
                    hintText: "Search"
                ),
                onChanged: (val){
                  setState(() {
                    searchAddr = val;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}


