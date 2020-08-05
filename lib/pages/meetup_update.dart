import 'package:event_management_app/models/meetup.dart';
import 'package:event_management_app/services/admin_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MeetupUpdate extends StatefulWidget {
  final String meetupID;
  final String meetupName;
  final String details;
  final String address;
  final String placeName;
  final String startDate;
  final String endDate;
  final int quota;
  final int registeredUserCount;

  MeetupUpdate(
      this.meetupID,
      this.meetupName,
      this.details,
      this.address,
      this.placeName,
      this.startDate,
      this.endDate,
      this.quota,
      this.registeredUserCount);

  @override
  MeetupUpdateState createState() => MeetupUpdateState();
}

class MeetupUpdateState extends State<MeetupUpdate> {
  final _formKey = GlobalKey<FormState>();

  final f = new DateFormat('dd.MM.yyyy');

  TextEditingController _meetupIdController;
  TextEditingController _meetupNameController;
  TextEditingController _detailsController;
  TextEditingController _addressController;
  TextEditingController _placeNameController;
  TextEditingController _startDateController;
  TextEditingController _endDateController;
  TextEditingController _quotaController;
  TextEditingController _registeredUserCountController;

  @override
  void initState() {
    _meetupIdController = new TextEditingController(text: widget.meetupID);
    _meetupNameController = new TextEditingController(text: widget.meetupName);
    _detailsController = new TextEditingController(text: widget.details);
    _addressController = new TextEditingController(text: widget.address);
    _placeNameController = new TextEditingController(text: widget.placeName);
    _startDateController = new TextEditingController(text: widget.startDate);
    _endDateController = new TextEditingController(text: widget.endDate);
    _quotaController = new TextEditingController(text: widget.quota.toString());
    _registeredUserCountController =
        new TextEditingController(text: widget.registeredUserCount.toString());
    super.initState();
  }

  @override
  void dispose() {
    _meetupNameController.dispose();
    _meetupIdController.dispose();
    _detailsController.dispose();
    _addressController.dispose();
    _placeNameController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _quotaController.dispose();
    _registeredUserCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          title: Text("Meetup Update"),
          centerTitle: true,
        ),
        body: Builder(
            builder: (context) => Form(
                  key: _formKey,
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
                    margin: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          meetupIdWiget(),
                          meetupNameWidget(),
                          detailsWidget(),
                          addressWidget(),
                          placeNameWidget(),
                          startDateWidget(),
                          endDateWidget(),
                          quotaWidget(),
                          registeredUserCountWidget(),
                          updateButtonWidget(context),
                        ],
                      ),
                    ),
                  ),
                )));
  }

  Widget meetupIdWiget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _meetupIdController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Meetup ID should be filled";
          } else if (value.length != 5) {
            return "Meetup ID field should have 5 chars";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Meetup ID",
        ),
      ),
    );
  }

  Widget meetupNameWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _meetupNameController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Meetup name field should be filled";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Meetup Name",
        ),
      ),
    );
  }

  Widget detailsWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _detailsController,
        maxLines: 2,
        validator: (value) {
          if (value.isEmpty) {
            return "Details field should be filled";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Details",
        ),
      ),
    );
  }

  Widget addressWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _addressController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Address field should be filled";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Address",
        ),
      ),
    );
  }

  Widget placeNameWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _placeNameController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Place name field should be filled";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Place Name",
        ),
      ),
    );
  }

  Widget startDateWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _startDateController,
        maxLines: 1,
        keyboardType: TextInputType.datetime,
        validator: (value) {
          if (value.isEmpty) {
            return "Start Date field should be filled";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Start Date",
        ),
      ),
    );
  }

  Widget endDateWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _endDateController,
        maxLines: 1,
        keyboardType: TextInputType.datetime,
        validator: (value) {
          if (value.isEmpty) {
            return "End Date field should be filled";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "End Date",
        ),
      ),
    );
  }

  Widget quotaWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _quotaController,
        maxLines: 1,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.isEmpty) {
            return "Quota field should be filled";
          }
          int quota = int.parse(value);
          int registeredUserCount =
              int.parse(_registeredUserCountController.text);
          if (quota < 1) {
            return "Quota must be bigger than 0";
          } else if (quota < registeredUserCount) {
            return "Quota cannot be lower than registered user count";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Quota",
        ),
      ),
    );
  }

  Widget registeredUserCountWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _registeredUserCountController,
        maxLines: 1,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.isEmpty) {
            return "Registered user count should be filled";
          } else {
            int count = int.parse(value);
            int quota = int.parse(_quotaController.text);
            if (count > quota) {
              return "Registered user count cannot be bigger than quota";
            } else {
              return null;
            }
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Registered User Count",
        ),
      ),
    );
  }

  Widget updateButtonWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: RaisedButton(
        elevation: 8,
        color: Colors.green,
        child: Text(
          "Add New Meetup",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () {
          // If all fields are filled
          if (_formKey.currentState.validate()) {
            // Save the meetup
            print("here");
            DateTime dateTime = DateTime.parse(_startDateController.text);
            print(dateTime);

//            print(f.format(_startDateController.text).toString());
  //          print(f.format(_endDateController.text).toString());
            print("here");
            int _quota = int.parse(_quotaController.text);
            int _registredUserCount =
                int.parse(_registeredUserCountController.text);

            String startDateWithT = _startDateController.text.substring(0, 10);

            String endDateWithT = _endDateController.text.substring(0, 10);

            print(startDateWithT);
            print(endDateWithT);
            //DateTime startDate = DateTime.parse(_startDateController.text);
            //DateTime endDate = DateTime.parse(_endDateController.text);
            AdminService adminService = new AdminService();
            Meetup meetup = new Meetup(
              meetupID: _meetupIdController.text,
              meetupName: _meetupNameController.text,
              details: _detailsController.text,
              address: _addressController.text,
              placeName: _placeNameController.text,
              startDate: startDateWithT,
              endDate: endDateWithT,
              quota: _quota,
              registeredCount: _registredUserCount,
            );
            adminService.updateMeetup(meetup).then((response) {
              if (response.statusCode < 400) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Meetup is updaetd')));
              } else {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Meetup could not updated')));
              }
            }).catchError((onError) {
              print(onError);
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Something went wrong')));
            });
          } else {
            // If fields are empty
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Error!')));
          }
        },
      ),
    );
  }
}
