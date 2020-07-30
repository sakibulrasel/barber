import 'dart:async';

import 'package:barbar_shop/controller/dashboard_controller.dart';
import 'package:barbar_shop/controller/profile_controller.dart';
import 'package:barbar_shop/provider/auth_provider.dart';
import 'package:barbar_shop/screen/dashboard_screen.dart';
import 'package:barbar_shop/screen/google_map_screen.dart';
import 'package:barbar_shop/screen/profile_screen.dart';
import 'package:barbar_shop/utils/global_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AboutWidget extends StatefulWidget {
  final bool isEditable;
  final double lat,lan;
  final String role,username;
  AboutWidget({this.isEditable,this.lat, this.lan,this.role,this.username});
  @override
  _AboutWidgetState createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {


  static String businessName = "";
  String startFrom = "";
  String address = "";
  String startTime="";
  String endTime="";
  String offDayStartTime="";
  String offDayendTime="";

  TextEditingController businessNameController;
  TextEditingController startFromController ;
  TextEditingController addressController;
  TimeOfDay _time = TimeOfDay.now();
  Future<TimeOfDay> selectTime(BuildContext context) async{
    _time = await showTimePicker(
        context: context,
        initialTime: _time
    );
    return _time;
  }

  businessTextValue() {
    print("title text field: ${businessNameController.text}");
    return businessNameController.text;
  }

  @override
  void initState() {

    ProfileController.getUserData().then((value){
      if(value!=null){
        print(value.data.toString());
       setState(() {
         if(value.data["businessName"]!=null){
           businessName = value.data["businessName"].toString();
         }else{
           businessName="";
         }
         if(value.data["startFrom"]!=null){
           startFrom = value.data["startFrom"].toString();
         }else{
           startFrom="";
         }
         if(value.data["address"]!=null){
           address = value.data["address"].toString();
         }else{
           address = address;
         }
         if(value.data["startTime"]!=null){
           startTime = value.data["startTime"].toString();
         }
         if(value.data["endTime"]!=null){
           endTime = value.data["endTime"].toString();
         }
         if(value.data["offdaystartTime"]!=null){
           offDayStartTime = value.data["offdaystartTime"].toString();
         }
         if(value.data["offdayendTime"]!=null){
           offDayendTime = value.data["offdayendTime"].toString();
         }
       });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var userName = store.get("userName");
    final auth = Provider.of<AuthProvider>(context);
    return SingleChildScrollView(
      child: Container(
         child: Column(
           children: <Widget>[
             Container(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: <Widget>[
                   Container(
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

                       child: Text(
                         "Start From",
                         style: TextStyle(
                             fontSize: 14
                         ),
                       )
                   ),
                 ],
               ),
             ),
             Container(

               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: <Widget>[
                   Container(
                       width: 150,
                       child: widget.isEditable?TextField(
                         keyboardType: TextInputType.text,
                          onChanged: (value){
                            businessName = value;
                          },
                         decoration: InputDecoration(
                             hintStyle: TextStyle(
                                 fontSize: 12
                             ),
                             hintText: "Business Name"
                         ),
                         style: TextStyle(
                           fontSize: 12
                         ),
                         controller: businessName==""?businessNameController=TextEditingController():businessNameController=TextEditingController(
                             text: businessName
                         ),

                       ):Container(
                         margin: EdgeInsets.only(top: 15),
                         child: Text(
                           businessName==""?"Plese update Your Business Name":businessName,
                           style: TextStyle(
                               fontSize: 12
                           ),
                         ),
                       )
                   ),
                   Container(
                       width: 150,
                       child: widget.isEditable?TextField(
                         keyboardType: TextInputType.text,
                         onChanged: (value){
                           startFrom = value;
                         },
                         decoration: InputDecoration(
                             hintStyle: TextStyle(
                                 fontSize: 12
                             ),
                             hintText: "Start From"
                         ),
                         style: TextStyle(
                           fontSize: 12
                         ),
                         controller: startFrom==""?startFromController=TextEditingController():startFromController=TextEditingController(text: startFrom),
                       ):Container(
                         margin: EdgeInsets.only(top: 15),
                         child: Text(
                           startFrom==""?"Please Update Your Start Amount":startFrom+" \$",
                           style: TextStyle(
                               fontSize: 12
                           ),
                         ),
                       )
                   ),
                 ],
               ),
             ),
             Container(
               margin: EdgeInsets.only(top: 5,),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: <Widget>[
                   Container(
                       width: MediaQuery.of(context).size.width,
                       padding: EdgeInsets.only(left: 20, right: MediaQuery.of(context).size.width/2),
                       child: widget.isEditable?Container(
                         padding: EdgeInsets.only(right: 20),
                         child: TextField(
                           onChanged: (value){
                             address = value;
                           },
                           keyboardType: TextInputType.text,
                           decoration: InputDecoration(
                               hintStyle: TextStyle(
                                   fontSize: 12
                               ),
                               hintText: "Address"
                           ),
                           maxLines: 4,
                           style: TextStyle(
                             fontSize: 12
                           ),
                           controller: address==""?addressController=TextEditingController():addressController=TextEditingController(text: address),
                         ),
                       ):Container(
                         margin: EdgeInsets.only(top: 15),
                         child: Text(
                           address==""?"Please Update Your Address":address,
                           style: TextStyle(
                               fontSize: 12
                           ),
                         ),
                       )
                   ),

                 ],
               ),
             ),

             Container(
               margin: EdgeInsets.only(top: 25,left: 20),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: <Widget>[
                   Container(
                       width: 150,
                       child: Text(
                         "Opening Hour",
                         style: TextStyle(
                             fontSize: 14
                         ),
                       )
                   ),

                 ],
               ),
             ),

             Container(
               margin: EdgeInsets.only(top: 5),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: <Widget>[
                   Container(
                       width: 150,
                       child: Container(
                         child: Text(
                           "Monday - Friday",
                           style: TextStyle(
                               fontSize: 12
                           ),
                         ),
                       )
                   ),
                   Container(

                       width: 150,
                       child: widget.isEditable?Row(
                         children: <Widget>[
                           Container(
                             color:Colors.blue,
                             margin: EdgeInsets.only(right: 5),
                             padding: EdgeInsets.only(left: 2, right: 2,top: 8),
                             width: 70,
                             height: 30,
                             child: GestureDetector(
                               onTap: (){
                                 selectTime(context).then((value){
                                   setState(() {
                                     final MaterialLocalizations localizations = MaterialLocalizations.of(context);

                                     startTime = localizations.formatTimeOfDay(value);
                                   });
                                 });

                               },
                               child: Text(
                                   startTime==""?"Start Time":startTime,
                                 style: TextStyle(
                                     fontSize: 9,
                                   color: Colors.white
                                 ),
                                 textAlign: TextAlign.center,
                               ),
                             ),
//
                           ),
                           Container(
                             color:Colors.blue,
                             margin: EdgeInsets.only(left: 5),
                             padding: EdgeInsets.only(left: 2, right: 2,top: 8),
                             width: 70,
                             height: 30,
                             child: GestureDetector(
                               onTap: (){
                                 selectTime(context).then((value){
                                   setState(() {
                                     final MaterialLocalizations localizations = MaterialLocalizations.of(context);

                                     endTime = localizations.formatTimeOfDay(value);
                                   });
                                 });

                               },
                               child: Text(
                                 endTime==""?"End Time":endTime,
                                 style: TextStyle(
                                     fontSize: 9,
                                     color: Colors.white
                                 ),
                                 textAlign: TextAlign.center,
                               ),
                             ),
//
                           ),
                         ],
                       ):Container(
                         margin: EdgeInsets.only(top: 15),
                         child: Text(
                           startTime==""?"Please Update Your Start and End time":
                           startTime+" - "+endTime,
                           style: TextStyle(
                               fontSize: 12
                           ),
                         ),
                       )
                   ),
                 ],
               ),
             ),

             Container(
               margin: EdgeInsets.only(top: 15),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: <Widget>[
                   Container(
                       width: 150,
                       child: Container(
                         child: Text(
                           "Saturday",
                           style: TextStyle(
                               fontSize: 12
                           ),
                         ),
                       )
                   ),
                   Container(
                       width: 150,
                       child: widget.isEditable?Row(
                         children: <Widget>[
                           Container(
                             color:Colors.blue,
                             margin: EdgeInsets.only(right: 5),
                             padding: EdgeInsets.only(left: 2, right: 2,top: 8),
                             width: 70,
                             height: 30,
                             child: GestureDetector(
                               onTap: (){
                                 selectTime(context).then((value){
                                   setState(() {
                                     final MaterialLocalizations localizations = MaterialLocalizations.of(context);

                                     offDayStartTime = localizations.formatTimeOfDay(value);
                                   });
                                 });

                               },
                               child: Text(
                                 offDayStartTime==""?"Start Time":offDayStartTime,
                                 style: TextStyle(
                                     fontSize: 9,
                                     color: Colors.white
                                 ),
                                 textAlign: TextAlign.center,
                               ),
                             ),
//
                           ),
                           Container(
                             color:Colors.blue,
                             margin: EdgeInsets.only(left: 5),
                             padding: EdgeInsets.only(left: 2, right: 2,top: 8),
                             width: 70,
                             height: 30,
                             child: GestureDetector(
                               onTap: (){
                                 selectTime(context).then((value){
                                   setState(() {
                                     final MaterialLocalizations localizations = MaterialLocalizations.of(context);

                                     offDayendTime = localizations.formatTimeOfDay(value);
                                   });
                                 });

                               },
                               child: Text(
                                 offDayendTime==""?"End Time":offDayendTime,
                                 style: TextStyle(
                                     fontSize: 9,
                                     color: Colors.white
                                 ),
                                 textAlign: TextAlign.center,
                               ),
                             ),
//
                           ),
                         ],
                       ):Container(
                         child: Text(
                           offDayStartTime==""?"Please Update Your Start and End time":
                           offDayStartTime+" - "+offDayendTime,
                           style: TextStyle(
                               fontSize: 12
                           ),
                         ),
                       )
                   ),
                 ],
               ),
             ),

             widget.isEditable?Container(
               margin: EdgeInsets.only(top: 30),
               width: MediaQuery.of(context).size.width,
               child: Center(
                 child: ButtonTheme(
                   minWidth:MediaQuery.of(context).size.width /2,
                   child: RaisedButton(
                     onPressed: (){
                       String u = userName();
                       if(u.isEmpty){
                         Toast.show("Please Enter Your Name", context,gravity: Toast.CENTER);
                       }else{

                         if(businessNameController.text.isEmpty){
                           Toast.show("Please Enter Your Business Name", context,gravity: Toast.CENTER);
                         }else{
                           if(startFromController.text.isEmpty){
                             Toast.show("Please Enter Your Starting Amount", context,gravity: Toast.CENTER);
                           }else{
                             if(addressController.text.isEmpty){
                               Toast.show("Please Enter Your Address", context,gravity: Toast.CENTER);
                             }else{
                               if(startTime==""){
                                 Toast.show("Please Select Your Office Start Time", context,gravity: Toast.CENTER);
                               }else{
                                 if(endTime==""){
                                   Toast.show("Please Select Your Office End Time", context,gravity: Toast.CENTER);
                                 }else{
                                   if(offDayStartTime==""){
                                     Toast.show("Please Select Your Off Day Office Start Time", context,gravity: Toast.CENTER);
                                   }else{
                                     if(offDayendTime==""){
                                       Toast.show("Please Select Your Off Day Office Start Time", context,gravity: Toast.CENTER);
                                     }else{
                                       auth.updateProfile(
                                           u,
                                           businessNameController.text,
                                           startFromController.text,
                                           addressController.text,
                                           startTime,
                                           endTime,
                                           offDayStartTime,
                                           offDayendTime).then((_){
                                         print("success");
                                         Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen(i: 0,)),);
                                       });
                                     }
                                   }
                                 }
                               }
                             }
                           }
                         }
                       }
                     },
                      child: Text(
                          "Update",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                   ),
                 ),
               ),
             ):Container(),
           ],
         ),
      ),
    );
  }
}
