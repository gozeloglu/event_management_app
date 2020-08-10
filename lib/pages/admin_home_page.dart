import 'package:event_management_app/components/tab_bar.dart';
import 'package:event_management_app/pages/admin_meetup_detail.dart';
import 'package:event_management_app/services/admin_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'admin/admin_add_meetup.dart';
import 'admin/admin_profile.dart';
import 'admin/admin_qr_list.dart';
import 'admin/admin_report_list.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({Key key, this.username}) : super(key: key);
  final String username;

  @override
  AdminHomeState createState() => AdminHomeState();
}

class AdminHomeState extends State<AdminHomePage> {
  bool _refresh = false;
  Future<List<dynamic>> meetupList;
  AdminService adminService = new AdminService();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    meetupList = adminService.getAllMeetups();
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
                    colors: [Colors.red, Colors.cyan],
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
                          builder: (context) => new AdminProfile(
                                username: widget.username,
                              )));
                }
              },
            ),
            ListTile(
              title: Text(
                "QR Code",
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(Icons.camera),
              onTap: () {
                // TODO Fill in this part

                if (_scaffoldKey.currentState.isDrawerOpen) {
                  _scaffoldKey.currentState.openEndDrawer();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new QRCodeList()));
                }
              },
            ),
            ListTile(
              title: Text(
                "Report",
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(Icons.pie_chart),
              onTap: () {
                if (_scaffoldKey.currentState.isDrawerOpen) {
                  _scaffoldKey.currentState.openEndDrawer();
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new ReportList()));
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _handleMeetupAddState(context);
        },
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
                          _handleMeetupDeleteState(
                              context, snapshot.data[index]["meetupID"]);
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

  /// This function handles the meetup add page state management
  /// If user uses the phone's back button or app bar back button
  /// it just set states
  /// If meetup is added successfully, it shows up a snack bar
  void _handleMeetupAddState(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminAddMeetup()));

    if (result == null || result == false) {
      setState(() {});
    } else if (result) {
      setState(() {});
      final snackBar = SnackBar(
        content: Text("New meetup is added!", style: TextStyle(fontSize: 20)),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  /// This function handles the meetup delete state management
  /// If user uses the phone's back button or app bar back button
  /// it just set states
  /// If meetup is deleted successfully, it shows up a snack bar
  void _handleMeetupDeleteState(BuildContext context, String meetupID) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new AdminMeetupDetail(meetupID)));

    if (result == null || result == false) {
      setState(() {});
    } else if (result) {
      setState(() {});
      final snackBar = SnackBar(
          content: Text(
        "Meetup is deleted",
        style: TextStyle(fontSize: 20),
      ));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
}
