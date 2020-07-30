import 'package:barbar_shop/controller/dashboard_controller.dart';
import 'package:barbar_shop/provider/auth_provider.dart';
import 'package:barbar_shop/provider/dashboard_provider.dart';
import 'package:barbar_shop/screen/chat_page.dart';
import 'package:barbar_shop/screen/chatlist_page.dart';
import 'package:barbar_shop/screen/dashboard_screen.dart';
import 'package:barbar_shop/screen/home_screen.dart';
import 'package:barbar_shop/screen/new_group_page.dart';
import 'package:barbar_shop/screen/worker_filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AuthProvider.initialize()),
    ChangeNotifierProvider.value(value: DashboardProvider.initialize())
  ],
    child: MyApp(),));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String role ="";
  bool isLoading=true;

  Future<String> checkRole() async{

  }

  @override
  void initState() {
//    DashboardController.checkRole().then((value){
//      setState(() {
//        role = DashboardController.role;
//        isLoading = false;
//      });
//    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
        routes: {

          '/chat': (_) => ChatPage(),
          '/new': (_) => NewGroupPage(),
          '/filter': (_) => WorkerFilterScreen(),
        },
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        home: HomePage()
    );
  }
}

