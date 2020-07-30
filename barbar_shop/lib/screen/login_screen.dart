import 'package:barbar_shop/animation/fade_animation.dart';
import 'package:barbar_shop/provider/auth_provider.dart';
import 'package:barbar_shop/screen/dashboard_screen.dart';
import 'package:barbar_shop/screen/home_screen.dart';
import 'package:barbar_shop/screen/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
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
                      if(auth.isEmail(email.text)){
                        FirebaseAuth _auth = FirebaseAuth.instance;
                        auth.loginWithEmail(email: email.text, password: password.text).then((value){
                         if(value){
                           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                               DashboardScreen(i: 2,)), (Route<dynamic> route) => false);
                         }else{
                           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                               LoginPage()), (Route<dynamic> route) => false);
                         }
                        });
                      }else{
                        Toast.show("Email is not valid", context,gravity: Toast.CENTER);
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
                          "Sign In", style: TextStyle(
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
                        Text("Don't Have an Account? "),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()),);
                          },
                          child: Text(
                              "Create a New",
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