import 'dart:convert';

import 'package:event_management_app/services/admin_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'admin/participant_details.dart';

class ParticipantList extends StatefulWidget {
  ParticipantList({Key key, this.meetupID, this.meetupName}) : super(key: key);

  final int meetupID;
  final String meetupName;

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
                  if (snapshot.data.length == 0) {
                    return Center(
                      child: Text(
                        "There is no participant!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                    );
                  } else {
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
                              title: Text(
                                participantFirstNameList[index] +
                                    " " +
                                    participantLastNameList[index],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                participantUsernameList[index],
                                style: TextStyle(fontSize: 20),
                              ),
                              onTap: () {
                                // TODO Participant details page
                                /// ParticipantDetails
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            ParticipantDetails(
                                              username: participantUsernameList[
                                                  index],
                                              meetupName: widget.meetupName,
                                            )));
                              },
                            ),
                          );
                        });
                  }
                } else if (snapshot.data == null) {
                  print("No data");
                  print(snapshot.data);
                  //noDataMessage();
                  return Center(
                    child: Text(
                      "Book basket is empty!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "There is no participant!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                  );
                }
              }),
        ));
  }
}
