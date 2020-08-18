import 'package:event_management_app/models/meetup.dart';
import 'package:event_management_app/pages/admin/admin_question_page.dart';
import 'package:event_management_app/pages/map_page.dart';
import 'package:event_management_app/services/admin_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../admin_participant_list_page.dart';

import 'meetup_update.dart';

class AdminMeetupDetail extends StatefulWidget {
  AdminMeetupDetail(int meetupId, bool _canAnswer) {
    this.meetupId = meetupId;
    this.canAnswer = _canAnswer;
  }

  int meetupId;
  bool canAnswer;

  @override
  MeetupDetailState createState() => MeetupDetailState();
}

class MeetupDetailState extends State<AdminMeetupDetail> {
  Future<Meetup> futureMeetup;
  AdminService adminService = new AdminService();
  String meetupName;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    futureMeetup = adminService.getMeetup(widget.meetupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 10,
        title: Text("Meetup Detail"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(false);
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
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ParticipantList(
                            meetupID: widget.meetupId,
                            meetupName: meetupName,
                          )));
            },
          ),
        ],
      ),
      floatingActionButton: widget.canAnswer
          ? FloatingActionButton(
              backgroundColor: Colors.red[800],
              elevation: 10,
              child: Icon(
                Icons.question_answer,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => QuestionListPage(
                              meetupID: widget.meetupId,
                            )));
              },
            )
          : null,
      body: Center(
        child: FutureBuilder<Meetup>(
          future: adminService.getMeetup(widget.meetupId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              meetupName = snapshot.data.meetupName;
              return Container(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Meetup ID",
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            snapshot.data.meetupID.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Meetup Name",
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            snapshot.data.meetupName,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Details",
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            snapshot.data.details,
                            maxLines: 2,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Address",
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            snapshot.data.address,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Place Name",
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            snapshot.data.placeName,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Start Date",
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            snapshot.data.startDate,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "End Date",
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            snapshot.data.endDate,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Quota",
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            snapshot.data.quota.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Registered User Count",
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            snapshot.data.registeredCount.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Divider(
                          height: 20.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: FractionalOffset.bottomLeft,
                                child: MaterialButton(
                                  color: Colors.red,
                                  height: 48,
                                  padding:
                                      const EdgeInsets.fromLTRB(48, 0, 48, 0),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20)),
                                  onPressed: () {
                                    adminService
                                        .deleteMeetup(widget.meetupId)
                                        .then((response) {
                                      if (response.statusCode < 400) {
                                        Navigator.of(context).pop(true);
                                      } else {
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Meetup could not delete!')));
                                      }
                                    }).catchError((onError) {
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Something went wrong')));
                                    });
                                  },
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: FractionalOffset.bottomRight,
                                child: MaterialButton(
                                  color: Colors.green,
                                  height: 48,
                                  padding:
                                      const EdgeInsets.fromLTRB(48, 0, 48, 0),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20)),
                                  onPressed: () {
                                    Meetup updatedMeetup = Meetup(
                                        meetupID: snapshot.data.meetupID,
                                        meetupName: snapshot.data.meetupName,
                                        details: snapshot.data.details,
                                        address: snapshot.data.address,
                                        placeName: snapshot.data.placeName,
                                        startDate: snapshot.data.startDate,
                                        endDate: snapshot.data.endDate,
                                        quota: snapshot.data.quota,
                                        registeredCount:
                                            snapshot.data.registeredCount);
                                    _handleUpdateMeetupState(
                                        context, updatedMeetup);
                                  },
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ));
            } else if (snapshot.hasError) {
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

  /// This method handles the state management after update page
  /// @param context is the page's context
  /// @param meetup stores the updated meetup information
  void _handleUpdateMeetupState(BuildContext context, Meetup meetup) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new MeetupUpdate(
                meetup.meetupID,
                meetup.meetupName,
                meetup.details,
                meetup.address,
                meetup.placeName,
                meetup.startDate,
                meetup.endDate,
                meetup.quota,
                meetup.registeredCount)));

    if (result == null || result == false) {
      setState(() {});
    } else {
      setState(() {});
      final snackBar = SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            "Meetup is updated",
            style: TextStyle(fontSize: 20),
          ));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
}
