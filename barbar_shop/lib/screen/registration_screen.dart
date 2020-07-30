import 'package:barbar_shop/animation/fade_animation.dart';
import 'package:barbar_shop/provider/auth_provider.dart';
import 'package:barbar_shop/screen/dashboard_screen.dart';
import 'package:barbar_shop/screen/home_screen.dart';
import 'package:barbar_shop/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  String _hintText="Registration as";
  double lat, lan;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        lat = position.latitude;
        lan = position.longitude;
      });
    }).catchError((e) {
      print(e);
    });

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 30,right: 30, top: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeAnimation(1.2,
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Image(
                        image: AssetImage("assets/images/logo.png"),
                      ),
                    ),
                  )
              ),
              FadeAnimation(1.2,
                  Container(
                    child: Center(
                      child: Text("Find the perfect Barberman",
                        style: TextStyle(color: Colors.black, fontSize: 12, ),),
                    ),
                  )
              ),
              SizedBox(height: 30,),
              FadeAnimation(1.5, Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Hexcolor("#99c2ff")
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey[300]))
                      ),
                      child: TextField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.black.withOpacity(.8),
                                fontSize: 14
                            ),
                            hintText: "Enter Your Email"
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey[300]))
                      ),
                      child: TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.remove_red_eye),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.black.withOpacity(.8),
                              fontSize: 14
                          ),
                          hintText: "Password",
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                      ),
                      child: DropdownButton(
                        hint: _hintText == null
                            ? Text('Dropdown',style: TextStyle(color: Colors.black),)
                            : Text(
                          _hintText,
                          style: TextStyle(color: Colors.black),
                        ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(color: Colors.black),
                        items: ['User', 'Barber'].map(
                              (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                                () {
                              _hintText = val;

                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              )),

              SizedBox(height: 40,),
              FadeAnimation(1.8, Center(
                child: InkWell(
                  onTap: (){

                    if(email.text.isEmpty || password.text.isEmpty){
                      Toast.show("Field cannot be empty", context,gravity: Toast.CENTER);
                    }else{
                      if(_hintText=="Registration as"){
                        Toast.show("Please select Registration type", context,gravity: Toast.CENTER);
                      }else{
                        if(password.text.length<6){
                          Toast.show("Password at least 6 character", context,gravity: Toast.CENTER);
                        }else{
                          if(auth.isEmail(email.text)){
                            auth.signUpWithEmail(email: email.text, password: password.text,role: _hintText).then((value){
                              if(value){
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                    DashboardScreen(i: 2,)), (Route<dynamic> route) => false);
                              }else{
                                Toast.show("Email is already used", context,gravity: Toast.CENTER);
                              }
                            });
                          }else{
                            Toast.show("Email is not valid", context,gravity: Toast.CENTER);
                          }
                        }
                      }

                    }

                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white
                    ),
                    child: Center(
                        child: Text(
                          "Sign Up", style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold
                        ),
                        )
                    ),
                  ),
                ),
              )),
              SizedBox(height: 40,),
              FadeAnimation(
                  1.8,
                  Center(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text("Already Have an Account? "),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.amber
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}