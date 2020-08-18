import 'package:event_management_app/models/mail.dart';
import 'package:event_management_app/models/meetup.dart';
import 'package:event_management_app/models/question.dart';
import 'package:event_management_app/pages/qr_code.dart';
import 'package:event_management_app/services/admin_service.dart';
import 'package:event_management_app/services/participant_service.dart';
import 'package:event_management_app/services/question_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../map_page.dart';

class ParticipantMeetupDetail extends StatefulWidget {
  const ParticipantMeetupDetail({
    Key key,
    this.meetupID,
    this.username,
    this.isRegisterPage,
    this.startDate,
    this.isQRCodeVisible,
    this.firstName,
    this.lastName,
    this.email,
  }) : super(key: key);

  final int meetupID;
  final String username;
  final bool isRegisterPage;
  final String startDate;
  final bool isQRCodeVisible;
  final String firstName;
  final String lastName;
  final String email;

  @override
  ParticipantMeetupDetailState createState() =>
      ParticipantMeetupDetailState();
}

class ParticipantMeetupDetailState extends State<ParticipantMeetupDetail> {

  bool _refresh = false;
  ParticipantService participantService = new ParticipantService();
  AdminService adminService = new AdminService();
  TextEditingController _questionTextController = TextEditingController();
  QuestionService questionService = new QuestionService();
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _canAskQuestion = false;

  String _meetupName = "";
  int _registeredUserCount = 0;
  int _quota = 0;

  @override
  void initState() {
    if (_isMeetupToday(widget.startDate.split("-"))) {
      _canAskQuestion = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    _questionTextController.dispose();
    super.dispose();
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
              if (_canAskQuestion) {
                _displayQuestionDialog(context);
              } else {
                final snackBar = SnackBar(
                  duration: Duration(seconds: 1),
                    content: Text(
                  'Meetup is not started. You cannot ask your question!',
                  style: TextStyle(fontSize: 20),
                ));
                _scaffoldKey.currentState.showSnackBar(snackBar);
              }
            },
          ),
        ],
      ),
      floatingActionButton: widget.isQRCodeVisible
          ? FloatingActionButton(
              backgroundColor: Colors.green[800],
              elevation: 10,
              child: Icon(
                Icons.camera,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => QRCode(
                              meetupName: _meetupName,
                              registeredUserCount: _registeredUserCount,
                              quota: _quota,
                              participantLastName: widget.lastName,
                              participantName: widget.firstName,
                            )));
              },
            )
          : null,
      body: Center(
        child: FutureBuilder<Meetup>(
          future: participantService.getMeetupDetails(widget.meetupID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _meetupName = snapshot.data.meetupName;
              return Container(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("Meetup ID"),
                        subtitle: Text(snapshot.data.meetupID.toString()),
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
                                    String _subject =
                                        "See you at " + _meetupName;
                                    print(_subject);
                                    print(_meetupName);
                                    print(widget.firstName);
                                    String _mail = "Dear " + widget.firstName +
                                        ",\n\nThank you for attending " +
                                        _meetupName +
                                        ". We are looking for you!\n\nMeetup Name: " +
                                        _meetupName +
                                        "\nFirst Name: " +
                                        widget.firstName +
                                        "\nLast Name: " +
                                        widget.lastName;

                                    String _qrCodeMsg = _meetupName +
                                        ". We are looking for you!\n\nMeetup Name: " +
                                        _meetupName +
                                        "\nFirst Name: " +
                                        widget.firstName +
                                        "\nLast Name: " +
                                        widget.lastName;
                                    print(widget.email);
                                    Mail mail = generateMail(
                                        widget.email, _subject, _mail, _qrCodeMsg);
                                    participantService
                                        .registerMeetup(widget.username,
                                            widget.meetupID, mail)
                                        .then((response) {
                                      if (response.statusCode < 400) {
                                        setState(() {
                                          _refresh = !_refresh;
                                        });
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                duration: Duration(seconds: 1),
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
                                      print(onError.toString());
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
              key: _formKey,
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text(
                    "Cancel",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              new FlatButton(
                  onPressed: () {
                    if (_questionTextController.text.length > 0) {
                      Question newQuestion = Question(
                          askedQuestion: _questionTextController.text,
                          isAnswered: 0);
                      questionService
                          .saveNewQuestion(newQuestion, widget.meetupID)
                          .then((response) {
                        if (response.statusCode < 400) {
                          Navigator.pop(context);
                          final snackBar = SnackBar(
                              content: Text(
                            'Your question is sent!',
                            style: TextStyle(fontSize: 20),
                          ));
                          _scaffoldKey.currentState.showSnackBar(snackBar);
                        } else {
                          final snackBar = SnackBar(
                              content: Text(
                            'Your question could not asked',
                            style: TextStyle(fontSize: 20),
                          ));
                          _scaffoldKey.currentState.showSnackBar(snackBar);
                        }
                      }).catchError((onError) {
                        final snackBar = SnackBar(
                            content: Text(
                          'Something went wrong!',
                          style: TextStyle(fontSize: 20),
                        ));
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                      });
                    } else {
                      final snackBar = SnackBar(
                          content: Text(
                        'Error!',
                        style: TextStyle(fontSize: 20),
                      ));
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    }
                  },
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

  bool _isMeetupToday(List<String> meetupDate) {
    int meetupYear = int.parse(meetupDate[0]);
    int meeupMonth = int.parse(meetupDate[1]);
    int meetupDay = int.parse(meetupDate[2]);

    int todayDay = DateTime.now().toLocal().day.toInt();
    int todayMonth = DateTime.now().toLocal().month.toInt();
    int todayYear = DateTime.now().toLocal().year.toInt();

    if (meetupDay == todayDay) {
      if (meeupMonth == todayMonth) {
        if (meetupYear == todayYear) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Mail generateMail(String to, String subject, String body, String qrCodeMsg) {
    Mail mail =
        Mail(to: to, subject: subject, body: body, qrCodeMsg: qrCodeMsg);
    return mail;
  }
}
