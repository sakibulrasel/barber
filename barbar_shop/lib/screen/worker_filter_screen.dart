import 'package:barbar_shop/model/user_model.dart';
import 'package:barbar_shop/screen/dashboard_screen.dart';
import 'package:barbar_shop/widgets/custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
class WorkerFilterScreen extends StatefulWidget {
  final List<User> userList;
  WorkerFilterScreen({@required this.userList});
  @override
  _WorkerFilterScreenState createState() => _WorkerFilterScreenState();
}

class _WorkerFilterScreenState extends State<WorkerFilterScreen> {
  String rating="4";
  double distance=0;
  double ratings =4;
  bool istenChecked = false;
  bool isthirtyChecked = false;
  bool isanyChecked = false;
  double tenChecked=0;
  double thirtyChecked=0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Container(

        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
                "Reset",
              style: TextStyle(
                fontSize: 14
              ),
            ),
            SizedBox(width: 20,),
            GestureDetector(
              onTap: (){
                List<User> uList=[];
                List<User> useList=[];
                useList = widget.userList;
                widget.userList.forEach((user){
                  if(user.rating>=ratings){
                    uList.add(user);
                  }
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen(uList: uList,i: 0,isfiltered: true,)));
              },
              child: Text(
                "Filter",
                style: TextStyle(
                    fontSize: 14
                ),
                
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                  icon: Icon(Icons.clear)
              )
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20,top: 20),
            child: Text(
                "Ratings",
              style: TextStyle(
                fontSize: 16
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20,top: 10),
            child: Row(
              children: <Widget>[
                  SmoothStarRating(
                    rating: 4,
                    size: 25,
                    isReadOnly: false,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    allowHalfRating: true,
                    onRated: (value){
                      setState(() {
                        ratings = value;
                        rating = value.toString();
                      });
                      print(value);
                    },
                    spacing: 2.0
                  ),
                SizedBox(width: 20,),

                Container(
                  child: Text(
                    rating+" stars"
                  ),
                )

              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20,top: 20),
            child: Text(
              "Distance",
              style: TextStyle(
                  fontSize: 16
              ),
            ),
          ),
          Container(

            child: Slider(
              value: distance,
              min: 00.0,
              max: 60.0,
              divisions: 2,
              onChangeStart: (double value) {

              },
              onChangeEnd: (double value) {

              },
              onChanged: (double newValue) {
                setState(() {
                  if(newValue==0){
                    distance = 10;

                  }
                  if(newValue ==30){
                    distance = 30;
                  }
                  if(newValue ==60){
                    distance=newValue;
                  }
                 print("distance is "+distance.toString());
                });
              },
              activeColor: Colors.blue,
              inactiveColor: Colors.black45,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text("10 Miles"),
                ),
                Container(
                  child: Text("30 Miles"),
                ),
                Container(
                  child: Text("Everywhere"),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20,top: 20),
            child: Text(
              "Cost",
              style: TextStyle(
                  fontSize: 16
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: istenChecked,
                  onChanged: (value){
                    setState(() {
                      istenChecked = value;
                      if(istenChecked){
                        tenChecked=10;
                      }else{
                        tenChecked=0;
                      }
                    });
                  },
                ),
                Text("\$"),
                SizedBox(width: 30,),
                Checkbox(
                  value: isthirtyChecked,
                  onChanged: (value){
                    setState(() {
                      isthirtyChecked = value;
                      if(isthirtyChecked){
                        thirtyChecked = 30;
                      }else{
                        thirtyChecked = 0;
                      }
                    });
                  },
                ),
                Text("\$\$"),
                SizedBox(width: 30,),
                Checkbox(
                  value: isanyChecked,
                  onChanged: (value){
                      setState(() {
                        isanyChecked = value;

                      });
                  },
                ),
                Text("\$\$\$"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
