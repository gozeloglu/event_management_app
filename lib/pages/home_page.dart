import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePageStateful(),
    );
  }
}

class HomePageStateful extends StatefulWidget {
  HomePageStateful({Key key}) : super(key : key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePageStateful> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(100),
      child: Text("Home Page"),
    );
  }
}