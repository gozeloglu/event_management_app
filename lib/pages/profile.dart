import 'package:event_management_app/models/participant.dart';
import 'package:event_management_app/services/participant_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key, this.username}) : super(key: key);
  final String username;

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  ParticipantService participantService = new ParticipantService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<Participant>(
          future: participantService.getParticipantDetails(widget.username),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: ExactAssetImage("assets/logo.png"),fit: BoxFit.cover),
                        ),
                      ),
                      Divider(),
                      Container(
                        child: Text(
                          "Hello " + snapshot.data.firstName,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Divider(
                        height: 20,
                        color: Colors.black,
                      ),
                      ListTile(
                        title: Text("First Name"),
                        subtitle: Text(snapshot.data.firstName),
                      ),
                      ListTile(
                        title: Text("Last Name"),
                        subtitle: Text(snapshot.data.lastName),
                      ),
                      ListTile(
                        title: Text("Username"),
                        subtitle: Text(snapshot.data.userName),
                      ),
                      ListTile(
                        title: Text("Email"),
                        subtitle: Text(snapshot.data.email),
                      ),
                      ListTile(
                        title: Text("Age"),
                        subtitle: Text(snapshot.data.age.toString()),
                      ),
                      ListTile(
                        title: Text("Identity Number"),
                        subtitle: Text(snapshot.data.identityNumber),
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
                                },
                                child: Text(
                                  "Update My Profile",
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
        "There is no this kind of participants!",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
