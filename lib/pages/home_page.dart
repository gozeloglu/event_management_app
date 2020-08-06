import 'package:event_management_app/pages/participant_meetup_details.dart';
import 'package:event_management_app/services/participant_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  bool _refresh = false;
  ParticipantService participantService = new ParticipantService();

  @override
  void initState() {
    _refresh = !_refresh;
    super.initState();
  }

  List<String> _homePageSelections = <String>[
    "List Events",
    "Update Profile",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    colors: [Colors.red, Colors.cyan],
                  )),
            ),
            ListTile(
              title: Text("Profile"),
              onTap: () {
                // TODO Fill in this part

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("My Meetups"),
              onTap: () {
                // TODO Fill in this part

                Navigator.pop(context);
              },
            )
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
              List<String> meetupName = List();
              List<String> meetupDetails = List();

              for (int i = 0; i < snapshot.data.length; i++) {
                meetupName.add(snapshot.data[i]["meetupName"]);
                meetupDetails.add(snapshot.data[i]["details"]);
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
                        title: Text(meetupName[index]),
                        subtitle: Text(meetupDetails[index], maxLines: 1),
                        onTap: () {
                          // TODO Details page
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new ParticipantMeetupDetail(
                                      snapshot.data[index]["meetupID"])));
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
