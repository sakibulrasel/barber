import 'package:barbar_shop/controller/dashboard_controller.dart';
import 'package:barbar_shop/controller/discover_controller.dart';
import 'package:barbar_shop/controller/profile_controller.dart';
import 'package:barbar_shop/model/user_model.dart';
import 'package:barbar_shop/provider/dashboard_provider.dart';
import 'package:barbar_shop/screen/bookmark_screen.dart';
import 'package:barbar_shop/screen/chatlist_page.dart';
import 'package:barbar_shop/screen/discover_screen.dart';
import 'package:barbar_shop/screen/earnings_screen.dart';
import 'package:barbar_shop/screen/google_map_screen.dart';
import 'package:barbar_shop/screen/inbox_screen.dart';
import 'package:barbar_shop/screen/nearby_screen.dart';
import 'package:barbar_shop/screen/profile_screen.dart';
import 'package:barbar_shop/screen/scheduler_screen.dart';
import 'package:barbar_shop/screen/settings_screen.dart';
import 'package:barbar_shop/screen/statistics_screen.dart';
import 'package:barbar_shop/screen/users_screen.dart';
import 'package:barbar_shop/screen/withdraws_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
class DashboardScreen extends StatefulWidget {
  final int i;
  final bool isfiltered;
  final List<User> uList;
  DashboardScreen({ this.i,this.isfiltered,this.uList});
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
   int _index = 2;
   static  double lat;
   static  double lan;
   String role ="";
   bool isLoading=true;
   List<User> userList=[];

   @override
  void initState() {


       DashboardController.checkRole().then((value){
         setState(() {
           role = DashboardController.role;
           isLoading = false;
         });
       });
       _index = widget.i;
      ProfileController.getUserCurrentLocation().then((value){
       setState(() {
         lat = value.latitude;
         lan = value.longitude;
         if(widget.isfiltered){
           setState(() {
             userList = widget.uList;
           });
         }else{
           DiscoverController.getWorkerList(lat,lan).then((ulist){
             setState(() {
               userList = ulist;
             });
           });

         }
       });
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    Widget child;
    switch (_index) {
      case 0:
        child =role=="admin"?UserScreen():role=="Barber"?lat!=null?ProfileScreen(lat: lat,lan: lan,role: role,):CircularProgressIndicator():DiscoverScreen(lat: lat,lan: lan,userList: userList,);
        break;
      case 1:
        child = role=="admin"?StatisticScreen():role=="Barber"?SchedulerScreen():GoogleMapScreen();
        break;
      case 2:
        child = role=="admin"?ChatListPage():role=="Barber"?ChatListPage():ChatListPage();
        break;
      case 3:
        child = role=="admin"?WithdrawsScreen():role=="Barber"?EarningsScreen():BookmarkScreen();
        break;
      case 4:
        child = role=="admin"?SettingsScreen():role=="Barber"?WithdrawsScreen():ProfileScreen();
        break;
    }
    return Scaffold(
      body: SizedBox.expand(child: child),
      bottomNavigationBar: BottomNavigationBar(

        type: BottomNavigationBarType.shifting,
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        items: role=="Admin"?[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.supervised_user_circle,
                color: Colors.blue,
              ),
              title: Text(
                "Users",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10
                ),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.score,
                color: Colors.black,
              ),
              title: Text(
                "Statistics",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10
                ),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              title: Text(
                "Inbox",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10
                ),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.transfer_within_a_station,
                color: Colors.black,
              ),
              title: Text(
                "Withdraws",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10
                ),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10
                ),
              )
          ),
        ]:role=="Barber"?[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_pin,
                color: Colors.black,
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10
                ),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.schedule,
                color: Colors.black,
              ),
              title: Text(
                "Scheduler",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10
                ),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              title: Text(
                "Inbox",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10
                ),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.insert_chart,
                color: Colors.black,
              ),
              title: Text(
                "Earnings",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10
                ),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.transfer_within_a_station,
                color: Colors.black,
              ),
              title: Text(
                "Withdraw",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10
                ),
              )
          ),
        ]:[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              title: Text(
                  "Discover",
                style: TextStyle(
                  color: Colors.black,
                    fontSize: 10
                ),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.near_me,
                color: Colors.black,
              ),
              title: Text(
                "Nearby",
                style: TextStyle(
                    color: Colors.black,
                  fontSize: 10
                ),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              title: Text(
                "Inbox",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10
                ),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark,
                color: Colors.black,
              ),
              title: Text(
                "Bookmark",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10
                ),
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_pin,
                color: Colors.black,
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10
                ),
              )
          ),

        ],
      ),
    );
  }
}
