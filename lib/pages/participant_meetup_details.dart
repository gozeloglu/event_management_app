import 'package:event_management_app/models/meetup.dart';
import 'package:event_management_app/services/participant_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParticipantMeetupDetail extends StatefulWidget {
  ParticipantMeetupDetail(String meetupID, String username) {
    this.meetupID = meetupID;
    this.username = username;
  }

  String meetupID;
  String username;

  @override
  ParticipantMeetupDetailState createState() => ParticipantMeetupDetailState();
}

class ParticipantMeetupDetailState extends State<ParticipantMeetupDetail> {
  bool _refresh = false;
  ParticipantService participantService = new ParticipantService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Meetup Detail"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _refresh = !_refresh;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<Meetup>(
          future: participantService.getMeetupDetails(widget.meetupID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("Meetup ID"),
                        subtitle: Text(snapshot.data.meetupID),
                        leading: Icon(Icons.confirmation_number),
                      ),
                      ListTile(
                        title: Text("Meetup Name"),
                        subtitle: Text(snapshot.data.meetupName),
                        leading: Icon(Icons.event),
                      ),
                      ListTile(
                        title: Text("Details"),
                        subtitle: Text(snapshot.data.details, maxLines: 2),
                        leading: Icon(Icons.details),
                      ),
                      ListTile(
                        title: Text("Address"),
                        subtitle: Text(snapshot.data.address),
                        leading: Icon(Icons.home),
                      ),
                      ListTile(
                        title: Text("Place Name"),
                        subtitle: Text(snapshot.data.placeName),
                        leading: Icon(Icons.place),
                      ),
                      ListTile(
                        title: Text("Start Date"),
                        subtitle: Text(snapshot.data.startDate),
                        leading: Icon(Icons.date_range),
                      ),
                      ListTile(
                        title: Text("End Date"),
                        subtitle: Text(snapshot.data.endDate),
                        leading: Icon(Icons.calendar_today),
                      ),
                      ListTile(
                        title: Text("Quota"),
                        subtitle: Text(snapshot.data.quota.toString()),
                        leading: Icon(Icons.people),
                      ),
                      ListTile(
                        title: Text("Registered User Count"),
                        subtitle:
                            Text(snapshot.data.registeredCount.toString()),
                        leading: Icon(Icons.person),
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
                                onPressed: () {
                                  // TODO Fill in
                                  participantService
                                      .registerMeetup(
                                          widget.username, widget.meetupID)
                                      .then((response) {
                                    if (response.statusCode < 400) {
                                      setState(() {
                                        _refresh = !_refresh;
                                      });
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text(response.body)));
                                    } else {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text(
                                              'You could not registered to meetup!')));
                                    }
                                  }).catchError((onError) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text('Something went wrong')));
                                  });
                                },
                                child: Text(
                                  "Attend",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
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
        "There is no meetup!",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
