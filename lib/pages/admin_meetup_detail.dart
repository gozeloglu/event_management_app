import 'package:event_management_app/models/meetup.dart';
import 'package:event_management_app/services/admin_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminMeetupDetail extends StatefulWidget {
  AdminMeetupDetail(String meetupId) {
    this.meetupId = meetupId;
  }

  String meetupId;

  @override
  MeetupDetailState createState() => MeetupDetailState();
}

class MeetupDetailState extends State<AdminMeetupDetail> {
  Future<Meetup> futureMeetup;
  AdminService adminService = new AdminService();
  bool _refresh = false;

  @override
  void initState() {
    print(widget.meetupId);
    futureMeetup = adminService.getMeetup(widget.meetupId);
    super.initState();
  }

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
          future: adminService.getMeetup(widget.meetupId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("Meetup ID"),
                          subtitle: Text(snapshot.data.meetupID),
                        ),
                        ListTile(
                          title: Text("Meetup Name"),
                          subtitle: Text(snapshot.data.meetupName),
                        ),
                        ListTile(
                          title: Text("Details"),
                          subtitle: Text(snapshot.data.details, maxLines: 2),
                        ),
                        ListTile(
                          title: Text("Address"),
                          subtitle: Text(snapshot.data.address),
                        ),
                        ListTile(
                          title: Text("Place Name"),
                          subtitle: Text(snapshot.data.placeName),
                        ),
                        ListTile(
                          title: Text("Start Date"),
                          subtitle: Text(snapshot.data.startDate),
                        ),
                        ListTile(
                          title: Text("End Date"),
                          subtitle: Text(snapshot.data.endDate),
                        ),
                        ListTile(
                          title: Text("Quota"),
                          subtitle: Text(snapshot.data.quota.toString()),
                        ),
                        ListTile(
                          title: Text("Registered User Count"),
                          subtitle:
                              Text(snapshot.data.registeredCount.toString()),
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
                                  height: 64,
                                  padding:
                                      const EdgeInsets.fromLTRB(48, 0, 48, 0),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20)),
                                  onPressed: () {},
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
                                  height: 64,
                                  padding:
                                      const EdgeInsets.fromLTRB(48, 0, 48, 0),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20)),
                                  onPressed: () {},
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
}
