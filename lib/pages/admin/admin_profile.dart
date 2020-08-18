import 'dart:convert';

import 'package:event_management_app/models/admin_dto.dart';
import 'package:event_management_app/services/admin_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminProfile extends StatefulWidget {
  AdminProfile({Key key, this.username}) : super(key: key);
  final String username;

  @override
  AdminProfileState createState() => AdminProfileState();
}

class AdminProfileState extends State<AdminProfile> {
  AdminService adminService = new AdminService();
  bool _refresh;

  @override
  void initState() {
    _refresh = false;
    setState(() {
      _refresh = !_refresh;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<AdminDTO>(
          future: adminService.getAdminDetails(widget.username),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String _firstName =
                  Utf8Decoder().convert(snapshot.data.firstName.codeUnits);
              String _lastName =
                  Utf8Decoder().convert(snapshot.data.lastName.codeUnits);
              return Container(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: ExactAssetImage("assets/logo.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Divider(),
                      Container(
                        child: Text(
                          "Hello " + _firstName,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Divider(
                        height: 20,
                        color: Colors.black,
                      ),
                      ListTile(
                        title: Text(
                          "First Name",
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          _firstName,
                          style: TextStyle(fontSize: 18),
                        ),
                        leading: Icon(Icons.person),
                      ),
                      ListTile(
                        title: Text(
                          "Last Name",
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          _lastName,
                          style: TextStyle(fontSize: 18),
                        ),
                        leading: Icon(Icons.person),
                      ),
                      ListTile(
                        title: Text(
                          "Username",
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          snapshot.data.userName,
                          style: TextStyle(fontSize: 18),
                        ),
                        leading: Icon(Icons.perm_identity),
                      ),
                      ListTile(
                        title: Text(
                          "Email",
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          snapshot.data.email,
                          style: TextStyle(fontSize: 18),
                        ),
                        leading: Icon(Icons.email),
                      ),
                      ListTile(
                        title: Text(
                          "Age",
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          snapshot.data.age.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                        leading: Icon(Icons.date_range),
                      ),
                      ListTile(
                        title: Text(
                          "Identity Number",
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          snapshot.data.identityNumber,
                          style: TextStyle(fontSize: 18),
                        ),
                        leading: Icon(Icons.confirmation_number),
                      ),
                      Divider(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.data == null) {
              noDataMessage();
            }
            return Container(
              alignment: Alignment.center,
              height: 160.0,
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget noDataMessage() {
    return Center(
      child: Text(
        "There is no this kind of participants!",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
