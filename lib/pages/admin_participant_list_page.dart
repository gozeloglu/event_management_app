import 'dart:convert';

import 'package:event_management_app/services/admin_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParticipantList extends StatefulWidget {
  ParticipantList({Key key, this.meetupID}) : super(key: key);

  final String meetupID;

  ParticipantListState createState() => ParticipantListState();
}

class ParticipantListState extends State<ParticipantList> {
  AdminService adminService = new AdminService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          title: Text("Registered Participant List"),
          centerTitle: true,
        ),

        /// listAllParticipants
        body: Center(
          child: FutureBuilder<List<dynamic>>(
              future: adminService.listAllParticipants(widget.meetupID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<String> participantFirstNameList = List();
                  List<String> participantLastNameList = List();
                  List<String> participantUsernameList = List();

                  for (int i = 0; i < snapshot.data.length; i++) {
                    // Utf8Decoder().convert(snapshot.data.lastName.codeUnits)
                    participantFirstNameList.add(Utf8Decoder()
                        .convert(snapshot.data[i]["firstName"].codeUnits));
                    participantLastNameList.add(Utf8Decoder()
                        .convert(snapshot.data[i]["lastName"].codeUnits));
                    participantUsernameList.add(Utf8Decoder()
                        .convert(snapshot.data[i]["userName"].codeUnits));
                  }

                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15)),
                          elevation: 5,
                          margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: ListTile(
                            trailing: Icon(Icons.arrow_right),
                            leading: Icon(Icons.person),
                            title: Text(participantFirstNameList[index] +
                                " " +
                                participantLastNameList[index]),
                            subtitle: Text(participantUsernameList[index]),
                            onTap: () {
                              // TODO Participant details page
                            },
                          ),
                        );
                      });
                } else if (snapshot.data == null) {
                  noDataMessage();
                }
                return Container(
                  alignment: Alignment.center,
                  height: 160.0,
                  child: CircularProgressIndicator(),
                );
              }),
        ));
  }

  Widget noDataMessage() {
    return Center(
      child: Text(
        "There is no meetup!",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
