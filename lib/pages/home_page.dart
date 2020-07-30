import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key : key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      padding: EdgeInsets.all(100),
      child: Text("Home Page"),
      )
    );
  }
}