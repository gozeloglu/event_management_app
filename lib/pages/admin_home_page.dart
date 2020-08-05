import 'package:event_management_app/models/meetup.dart';
import 'package:event_management_app/pages/admin_add_meetup.dart';
import 'package:event_management_app/services/admin_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({Key key}) : super(key: key);

  @override
  AdminHomeState createState() => AdminHomeState();
}

class AdminHomeState extends State<AdminHomePage> {

  Future<List<dynamic>> meetupList;
  AdminService adminService = new AdminService();

  @override
  void initState() {
    print("init state");
    meetupList = adminService.getAllMeetups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // TODO Meetup will be added here
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AdminAddMeetup()));
        },
      ),
      appBar: AppBar(
        elevation: 10,
        title: Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: adminService.getAllMeetups(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("Data is done");
              List<String> meetupName = List();
              List<String> meetupId = List();

              for (int i = 0; i < snapshot.data.length; i++) {
                meetupName.add(snapshot.data[i]["meetupName"]);
                meetupId.add(snapshot.data[i]["meetupID"]);
              }

              print(meetupName);
              print("------------------");
              print(meetupId);
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      elevation: 5,
                      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: ListTile(
                        leading: Icon(Icons.event),
                        title: Text(meetupName[index]),
                        subtitle: Text(meetupId[index]),
                        onTap: (){
                          // TODO Details page
                        },
                      ),
                    );
                  });
            } else if (snapshot.data == null) {
              noDataMessage();
            }
            print("no data");

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
