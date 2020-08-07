import 'dart:convert';

import 'package:event_management_app/models/participant.dart';
import 'package:event_management_app/services/participant_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParticipantDetails extends StatefulWidget {
  ParticipantDetails({Key key, this.username, this.meetupName})
      : super(key: key);
  final String username;
  final String meetupName;

  ParticipantDetailState createState() => ParticipantDetailState();
}

class ParticipantDetailState extends State<ParticipantDetails> {
  ParticipantService participantService = new ParticipantService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Participant Details"),
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
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
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
                    ],
                  ),
                ),
              );
            } else if (snapshot.data == null) {
              return Center(
                child: Text(
                  "This participant could not find!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
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
}
