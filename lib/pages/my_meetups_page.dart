import 'package:event_management_app/pages/participant_meetup_details.dart';
import 'package:event_management_app/services/participant_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyMeetups extends StatefulWidget {
  MyMeetups({Key key, this.username}) : super(key: key);

  final String username;

  MyMeetupState createState() => MyMeetupState();
}

class MyMeetupState extends State<MyMeetups> {
  ParticipantService participantService = new ParticipantService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("My Meetups"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: participantService.getMyMeetups(widget.username),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<String> meetupNameList = List();
              List<String> meetupDetailList = List();

              for (int i = 0; i < snapshot.data.length; i++) {
                meetupNameList.add(snapshot.data[i]["meetupName"]);
                meetupDetailList.add(snapshot.data[i]["details"]);
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
                        title: Text(meetupNameList[index]),
                        subtitle: Text(meetupDetailList[index], maxLines: 1),
                        onTap: () {
                          // TODO Details page
                          _handleRebuildState(
                              context, snapshot.data[index]["meetupID"]);
                        },
                      ),
                    );
                  });
            } else if (snapshot.data == null) {
              print("Here");
              noDataMessage();
            }
            print("HERERRERE");
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

  void _handleRebuildState(BuildContext context, String meetupID) async {
    final result = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                new ParticipantMeetupDetail(meetupID, widget.username, false)));
    if (result[0]) {
      setState(() {});
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(result[1], style: TextStyle(fontSize: 20))));
    }
  }
}
