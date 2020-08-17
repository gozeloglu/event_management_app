import 'dart:convert';

import 'package:event_management_app/components/tab_bar.dart';
import 'package:event_management_app/pages/participant/participant_meetup_details.dart';
import 'package:event_management_app/pages/participant/profile.dart';
import 'package:event_management_app/services/participant_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_meetups_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.username, this.firstName, this.lastName, this.email})
      : super(key: key);
  final String username;
  final String firstName;
  final String lastName;
  final String email;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  bool _refresh = false;
  ParticipantService participantService = new ParticipantService();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _refresh = !_refresh;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: CircleAvatar(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/logo.png'),
                ),
                radius: 95,
              ),
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  gradient: new LinearGradient(
                    colors: [Colors.red, Colors.cyan, Colors.yellow],
                  )),
            ),
            ListTile(
              title: Text(
                "Profile",
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(Icons.person),
              onTap: () {
                // TODO Fill in this part
                if (_scaffoldKey.currentState.isDrawerOpen) {
                  _scaffoldKey.currentState.openEndDrawer();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Profile(
                                username: widget.username,
                              )));
                }
              },
            ),
            ListTile(
              title: Text(
                "My Meetups",
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(Icons.event),
              onTap: () {
                // TODO Fill in this part

                if (_scaffoldKey.currentState.isDrawerOpen) {
                  _scaffoldKey.currentState.openEndDrawer();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new MyMeetups(
                                username: widget.username,
                                firstName: widget.firstName,
                                lastName: widget.lastName,
                              )));
                }
              },
            ),
            Divider(
              height: 100,
              color: Colors.black,
            ),
            ListTile(
              title: Text(
                "Logout",
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                if (_scaffoldKey.currentState.isDrawerOpen) {
                  _scaffoldKey.currentState.openEndDrawer();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => TabBarStateless()),
                      (Route<dynamic> route) => false);
                }
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 10,
        title: Text("Home"),
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
        child: FutureBuilder<List<dynamic>>(
          future: participantService.getAllMeetups(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                Center(
                  child: Text(
                    "There is no meetup!",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              } else {
                List<String> meetupName = List();
                List<String> meetupDetails = List();
                List<String> meetupDates = List();

                for (int i = 0; i < snapshot.data.length; i++) {
                  meetupName.add(snapshot.data[i]["meetupName"]);
                  meetupDetails.add(snapshot.data[i]["details"]);
                  meetupDates.add(snapshot.data[i]["startDate"]);
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
                          leading: Icon(Icons.event),
                          title: Text(Utf8Decoder()
                              .convert(meetupName[index].codeUnits)),
                          subtitle: Text(
                              Utf8Decoder()
                                  .convert(meetupDetails[index].codeUnits),
                              maxLines: 1),
                          onTap: () {
                            // TODO Details page
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        new ParticipantMeetupDetail(
                                          meetupID: snapshot.data[index]
                                              ["id"],
                                          username: widget.username,
                                          isRegisterPage: true,
                                          startDate: meetupDates[index],
                                          isQRCodeVisible: false,
                                          firstName: widget.firstName,
                                          lastName: widget.lastName,
                                          email: widget.email,
                                        )));
                          },
                        ),
                      );
                    });
              }
            } else if (snapshot.data == null) {
              noDataMessage();
              // TODO Registered user count
              // TODO MeetupID otomatik oluşturulabilir
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
