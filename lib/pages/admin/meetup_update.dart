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

  DateTime startDate;
  DateTime endDate;


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
    startDate = DateTime.parse(widget.startDate);
    endDate = DateTime.parse(widget.endDate);
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
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
                          //meetupIdWiget(),
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
            prefixIcon: Icon(Icons.confirmation_number)),
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
            prefixIcon: Icon(Icons.event)),
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
            prefixIcon: Icon(Icons.details)),
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
            prefixIcon: Icon(Icons.home)),
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
            prefixIcon: Icon(Icons.place)),
      ),
    );
  }

  Widget startDateWidget() {
    return Container(
        padding: const EdgeInsets.all(15),
        child: RaisedButton(
            padding: const EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            onPressed: () {
              final date =
                  _selectStartDate(context).then((_) => setState(() {}));
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              height: 30.0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.date_range,
                                size: 18.0,
                                color: Colors.teal,
                              ),
                              SizedBox(width: 10),
                              Text(
                                startDate.toString().split(" ")[0],
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ]),
            )));
    /**return Container(
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
        prefixIcon: Icon(Icons.date_range)),
        ),
        );**/
  }

  Widget endDateWidget() {
    return Container(
        padding: const EdgeInsets.all(15),
        child: RaisedButton(
            padding: const EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            onPressed: () {
              _selectEndDate(context).then((_) => setState(() {}));
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              height: 30.0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.date_range,
                                size: 18.0,
                                color: Colors.teal,
                              ),
                              SizedBox(width: 10),
                              Text(
                                endDate.toString().split(" ")[0],
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ]),
            )));
    /**return Container(
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
        );**/
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
            prefixIcon: Icon(Icons.people)),
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
            prefixIcon: Icon(Icons.person)),
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
          "Update Meetup",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20)),
        onPressed: () {
          // If all fields are filled
          if (_formKey.currentState.validate()) {
            // Save the meetup
            int _quota = int.parse(_quotaController.text);
            int _registredUserCount =
                int.parse(_registeredUserCountController.text);

            String startDateWithT = _startDateController.text.substring(0, 10);

            String endDateWithT = _endDateController.text.substring(0, 10);

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
            adminService.updateMeetup(widget.meetupID, meetup).then((response) {
              if (response.statusCode < 400) {
                Navigator.of(context).pop(true);
                /*Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Meetup is updaetd')));*/
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'Meetup could not updated',
                  style: TextStyle(fontSize: 20),
                )));
              }
            }).catchError((onError) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                'Something went wrong',
                style: TextStyle(fontSize: 20),
              )));
            });
          } else {
            // If fields are empty
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
              'Error!',
              style: TextStyle(fontSize: 20),
            )));
          }
        },
      ),
    );
  }

  Future<DateTime> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: startDate,
        lastDate: DateTime(2100));
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
    return picked;
  }

  Future<Null> _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: startDate,
        lastDate: DateTime(2100));
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }
}
