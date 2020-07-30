import 'package:barbar_shop/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async{
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              LoginPage()), (Route<dynamic> route) => false);
        },
        child: Text("Logout"),
      ),
    );
  }
}
