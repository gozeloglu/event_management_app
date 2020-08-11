import 'package:event_management_app/models/meetup.dart';
import 'package:event_management_app/services/participant_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../map_page.dart';

class ParticipantMeetupDetail extends StatefulWidget {
  const ParticipantMeetupDetail(
      {Key key, this.meetupID, this.username, this.isRegisterPage})
      : super(key: key);

  final String meetupID;
  final String username;
  final bool isRegisterPage;

  @override
  ParticipantMeetupDetailState createState() => ParticipantMeetupDetailState();
}

class ParticipantMeetupDetailState extends State<ParticipantMeetupDetail> {
  bool _refresh = false;
  ParticipantService participantService = new ParticipantService();
  TextEditingController _questionTextController = TextEditingController();

  @override
  void dispose() {
    _questionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Meetup Detail"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop([false]);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => GoogleMapsPage()));
            },
          ),
          IconButton(
            icon: Icon(Icons.question_answer),
            onPressed: () {
              _displayQuestionDialog(context);
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
                                    const EdgeInsets.fromLTRB(32, 0, 32, 0),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20)),
                                onPressed: () {
                                  // TODO Fill in
                                  if (widget.isRegisterPage) {
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
                                                content: Text(response.body,
                                                    style: TextStyle(
                                                        fontSize: 20))));
                                      } else {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                          'You could not registered to meetup!',
                                          style: TextStyle(fontSize: 20),
                                        )));
                                      }
                                    }).catchError((onError) {
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Something went wrong',
                                                  style: TextStyle(
                                                      fontSize: 20))));
                                    });
                                  } else {
                                    participantService
                                        .unRegisterMeetup(
                                            widget.username, widget.meetupID)
                                        .then((response) {
                                      if (response.statusCode < 400) {
                                        Navigator.of(context).pop(
                                            [true, "Unregistered to meetup"]);
                                      } else {
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                            content: Text(
                                                'You could not unregistered to meetup!',
                                                style:
                                                    TextStyle(fontSize: 20))));
                                      }
                                    }).catchError((onError) {
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Something went wrong',
                                                  style: TextStyle(
                                                      fontSize: 20))));
                                    });
                                  }
                                },
                                child: Text(
                                  widget.isRegisterPage
                                      ? "Attend"
                                      : "Unregister",
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
        "There is no meetup!",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  _displayQuestionDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Ask Your Question",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: TextFormField(
              controller: _questionTextController,
              maxLines: 4,
              maxLength: 240,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Your Question"),
              validator: (value) {
                if (value.isEmpty) {
                  return "You should fill in the question field.";
                } else {
                  return null;
                }
              },
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {},
                  child: new Text(
                    "Cancel",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              new FlatButton(
                  onPressed: () {},
                  child: new Text(
                    "Ask",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ))
            ],
          );
        });
  }
}
