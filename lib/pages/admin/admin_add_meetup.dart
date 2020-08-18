import 'package:event_management_app/models/meetup.dart';
import 'package:event_management_app/services/admin_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminAddMeetup extends StatefulWidget {
  AdminAddMeetup({Key key}) : super(key: key);

  @override
  AdminAddMeetupState createState() => AdminAddMeetupState();
}

class AdminAddMeetupState extends State<AdminAddMeetup> {
  final _formKey = GlobalKey<FormState>();

  DateTime startDate = DateTime.now().toLocal();
  DateTime endDate = DateTime.now().toLocal();
  bool isStartDateSet = false;
  bool isEndDateSet = false;

  TextEditingController _meetupNameController = new TextEditingController();
  TextEditingController _detailsController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _placeNameController = new TextEditingController();

  TextEditingController _quotaController = new TextEditingController();

  @override
  void dispose() {
    _meetupNameController.dispose();
    _detailsController.dispose();
    _addressController.dispose();
    _placeNameController.dispose();
    _quotaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Add New Meetup"),
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
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            margin: const EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                meetupNameWidget(),
                detailsWidget(),
                addressWidget(),
                placeNameWidget(),
                startDateWidget(),
                endDateWidget(),
                quotaWidget(),
                addButtonWidget(context),
              ],
            )),
          ),
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
                                !isStartDateSet
                                    ? "Set Start Date"
                                    : startDate.toString().split(" ")[0],
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
                                !isEndDateSet
                                    ? "Set End Date"
                                    : endDate.toString().split(" ")[0],
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
          if (quota < 1) {
            return "Quota must be bigger than 0";
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

  Widget addButtonWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: RaisedButton(
        elevation: 8,
        color: Colors.green,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20)),
        child: Text(
          "Add New Meetup",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () {
          // If all fields are filled
          if (_formKey.currentState.validate()) {
            int _quota = int.parse(_quotaController.text);

            String startDateWithT = startDate.toString().split(" ")[0];
            String endDateWithT = endDate.toString().split(" ")[0];

            AdminService adminService = new AdminService();
            Meetup meetup = new Meetup(
              meetupName: _meetupNameController.text,
              details: _detailsController.text,
              address: _addressController.text,
              placeName: _placeNameController.text,
              startDate: startDateWithT,
              endDate: endDateWithT,
              quota: _quota,
              registeredCount: 0,
            );
            if (isStartDateSet && isEndDateSet) {
              adminService.addNewMeetup(meetup).then((response) {
                if (response.statusCode < 400) {
                  Navigator.of(context).pop(true);
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                    'Meetup could not saved',
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
              if (!isStartDateSet) {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'You should give start date',
                  style: TextStyle(fontSize: 20),
                )));
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'You should give end date',
                  style: TextStyle(fontSize: 20),
                )));
              }
            }
          } else {
            // If fields are empty
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
              'Error',
              style: TextStyle(fontSize: 20),
            )));
          }
        },
      ),
    );
  }

  /// This method creates the start date picker for adding new meetup
  /// @return Picked DateTime for start date
  Future<DateTime> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: startDate,
        lastDate: DateTime(2100));
    if (picked != null && picked != startDate) {
      setState(() {
        isStartDateSet = true;
        startDate = picked;
      });
    }
    return picked;
  }

  /// This method creates the end date picker for adding new meetup
  /// @return Picked DateTime for end date
  Future<Null> _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: startDate,
        lastDate: DateTime(2100));
    if (picked != null && picked != endDate) {
      setState(() {
        isEndDateSet = true;
        endDate = picked;
      });
    }
  }
}
