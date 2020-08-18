import 'package:event_management_app/services/admin_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'admin_report.dart';

class ReportList extends StatefulWidget {
  ReportList({Key key}) : super(key: key);

  ReportListState createState() => ReportListState();
}

class ReportListState extends State<ReportList> {
  AdminService adminService = new AdminService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Report"),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: adminService.getAllMeetups(),
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
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new AdminReport(
                                      registeredUserCount: snapshot.data[index]
                                          ["registeredUserCount"],
                                      quota: snapshot.data[index]["quota"])));
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
