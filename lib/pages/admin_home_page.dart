import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({Key key}) : super(key: key);

  @override
  AdminHomeState createState() => AdminHomeState();
}

class AdminHomeState extends State<AdminHomePage> {
  List<String> _homePageSelections = <String>[
    "List Events",
    "Update Profile",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: _homePageSelections.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_homePageSelections[index]),
            onTap: () {
              print(index);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
