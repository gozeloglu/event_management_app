import 'dart:convert';

import 'package:event_management_app/models/participant.dart';
import 'package:event_management_app/pages/participant/profile_update.dart';
import 'package:event_management_app/services/participant_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key, this.username}) : super(key: key);
  final String username;

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  ParticipantService participantService = new ParticipantService();
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
        child: FutureBuilder<Participant>(
          future: participantService.getParticipantDetails(widget.username),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: FractionalOffset.center,
                              child: MaterialButton(
                                color: Colors.green,
                                height: 64,
                                padding:
                                    const EdgeInsets.fromLTRB(48, 0, 48, 0),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20)),
                                onPressed: () async {
                                  // TODO Fill in
                                  final result = await Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => ProfileUpdate(
                                              firstName: _firstName,
                                              lastName: _lastName,
                                              username: snapshot.data.userName,
                                              email: snapshot.data.email,
                                              age: snapshot.data.age,
                                              identityNumber: snapshot
                                                  .data.identityNumber)));
                                  if (result == null) {
                                    setState(() {});
                                  } else if (result) {
                                    setState(() {});
                                  }
                                },
                                child: Text(
                                  "Update My Profile",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
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
